//
//  FMRegisterViewModel.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMRegisterViewModel.h"

@implementation FMRegisterViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:resultModel];
        
        // test code
        if (resultModel.isSuccess) {
            [self.registerSuccessSubject sendNext:resultModel];
        }
    }];
    
    [self.requestVerifyCodeCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:resultModel];
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
                params[@"mobile"] = [NSString stringWithFormat:@"%@,%lu", self.registerModel.phoneNumber, operationBrand];
                params[@"code"] = self.registerModel.verifyCode;
                params[@"password"] = self.registerModel.password;
                
                [networkMgr POST:kRegisterURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACCommand *)requestVerifyCodeCommand {
    if (! _requestVerifyCodeCommand) {
        @weakify(self)
        _requestVerifyCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
                // 运营品牌 1：Seventrees
                params[@"mobile"] = [NSString stringWithFormat:@"%@,%lu", self.registerModel.phoneNumber, operationBrand];
                // 申请验证码类型（login 登录验证码[默认]，register 注册验证码，pwd 找回密码验证码）
                params[@"type"] = @"register";
                
                [networkMgr POST:kSendVerifyCodeURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestVerifyCodeCommand;
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

- (RACSubject *)registerSuccessSubject {
    if (! _registerSuccessSubject) {
        _registerSuccessSubject = [RACSubject subject];
    }
    return _registerSuccessSubject;
}

- (FMRegisterModel *)registerModel {
    if (! _registerModel) {
        _registerModel = [[FMRegisterModel alloc] init];
    }
    return _registerModel;
}

@end
