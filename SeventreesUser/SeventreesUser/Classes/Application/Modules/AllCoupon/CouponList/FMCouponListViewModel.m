//
//  FMCouponListViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponListViewModel.h"

@implementation FMCouponListViewModel

- (void)fm_initialize {
    _status = 1;    // 默认请求参数
    
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
        }
        NSArray *couponEntitys = [[FMCouponModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        for (FMCouponModel *couponEntity in couponEntitys) {
            couponEntity.status = self->_status;
        }
        self->_couponEntitys = couponEntitys;
        
        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *status) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                if (status) self->_status = status.integerValue;
                [networkMgr GET:kCouponListQueryURIPath params:@{@"status": @(self->_status)} success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                    [self.showHintSubject sendNext:error.localizedDescription];
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
