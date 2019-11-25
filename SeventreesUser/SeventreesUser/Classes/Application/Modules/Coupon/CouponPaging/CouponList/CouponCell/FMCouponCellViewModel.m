//
//  FMCouponCellViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponCellViewModel.h"

@implementation FMCouponCellViewModel

- (void)fm_initialize {
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
        } else {
            [SVProgressHUD showSuccessWithStatus:resultModel.statusMsg];
        }
//        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *couponId) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"voucherId"] = self->_couponEntity.couponId;
                [networkMgr GET:kCouponGainURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                    @strongify(self)
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
