//
//  FMMeViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/1.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMeViewModel.h"

@implementation FMMeViewModel

- (void)fm_initialize {
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        FMMeModel *profileEntity = [FMMeModel mj_objectWithKeyValues:resultModel.jsonDict];
        self->_profileEntity = profileEntity;
        [self.refreshUISubject sendNext:profileEntity];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *couponId) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [networkMgr POST:kPersonalProfileQueryURIPath params:nil success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                    @strongify(self) [self.showHintSubject sendNext:error.localizedDescription];
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

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}

@end
