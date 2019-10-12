//
//  FMHomeViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeViewModel.h"

@implementation FMHomeViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        if ([resultModel.statusCode isEqualToString:@"OK"]) {
            [self.refreshUISubject sendNext:resultModel];
        }
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (!_requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
                params[@"latitude"] = @"123.0140080000"; // 纬度
                params[@"longitude"] = @"41.1409530000"; // 经度
//                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
//                params[@"name"] = @"鞋子";
                
                [networkMgr POST:kHomeListURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)nextActionSubject {
    if (! _nextActionSubject) {
        _nextActionSubject = [RACSubject subject];
    }
    return _nextActionSubject;
}

@end
