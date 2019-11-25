//
//  FMPayViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPayViewModel.h"

@implementation FMPayViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.choicePaymentSubject subscribeNext:^(id x) {
        @strongify(self)
        if (self->_paymentType == FMPayViewModelPaymentTypeAli) {
            self->_paymentType = FMPayViewModelPaymentTypeWechat;
        } else if (self->_paymentType == FMPayViewModelPaymentTypeWechat) {
            self->_paymentType = FMPayViewModelPaymentTypeAli;
        }
    }];
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        self.paymentEntity = [FMPayModel mj_objectWithKeyValues:resultModel.jsonDict];
        
        [self.refreshUISubject sendNext:nil];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"orderId"] = self->_orderId;
                [networkMgr POST:kOrderGoPaymentURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACCommand *)requestPaymentCommand {
    if (! _requestPaymentCommand) {
        @weakify(self)
        _requestPaymentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"orderId"] = self->_orderId;
                [networkMgr POST:kOrderGoPaymentURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestPaymentCommand;
}

- (RACSubject *)choicePaymentSubject {
    if (! _choicePaymentSubject) {
        _choicePaymentSubject = [RACSubject subject];
    }
    return _choicePaymentSubject;
}

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

@end
