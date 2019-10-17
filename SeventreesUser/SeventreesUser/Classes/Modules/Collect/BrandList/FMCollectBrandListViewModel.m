//
//  FMCollectBrandListViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/17.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectBrandListViewModel.h"

@implementation FMCollectBrandListViewModel

- (void)fm_initialize {
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            DLog(@"请求失败，接口错误！statusCode == %@", resultModel.statusCode);
        }
        self->_brandEntitys = [FMCollectBrandModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"brandList"]];
        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
                params[@"brandName"] = self->_searchText ?: @"";
                [networkMgr POST:kHomeAueryBrandURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
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

@end
