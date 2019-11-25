//
//  FMOrderPayViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderPayViewModel.h"

@implementation FMOrderPayViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestCancelCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"订单已取消"];
        [self.reloadDataSubject sendNext:self.orderId];
    }];
    
    [self.requestReceivingCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"确认收货成功"];
        [self.reloadDataSubject sendNext:self.orderId];
    }];
}

- (RACCommand *)requestCancelCommand {
    if (! _requestCancelCommand) {
        @weakify(self)
        _requestCancelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"id"] = self.orderId;
                [networkMgr POST:kOrderCancelURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestCancelCommand;
}

- (RACCommand *)requestReceivingCommand {
    if (! _requestReceivingCommand) {
        @weakify(self)
        _requestReceivingCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"id"] = self->_orderId;
                [networkMgr POST:kOrderConfirmReceivingURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestReceivingCommand;
}

- (RACSubject *)reloadDataSubject {
    if (! _reloadDataSubject) {
        _reloadDataSubject = [RACSubject subject];
    }
    return _reloadDataSubject;
}

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}

@end
