//
//  FMLoginViewModel.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMLoginViewModel.h"

@implementation FMLoginViewModel

- (void)fm_initialize {
    
    @weakify(self)

    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:x]; // 登录成功发UI信号
        [self.loginSuccessSubject sendNext:x]; // 登录成功
    }];
    
    [[self.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            DLog(@"（命令执行中..）");
        } else {
            DLog(@"（命令未开始 / 命令执行完成");
        }
    }];
    
    self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self.loginModel, account), RACObserve(self.loginModel, password)] reduce:^id (NSString *account, NSString *password) {
        return @(account.length == 11 && password.length);
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (!_requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
//                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
//                // 运营品牌 2：Seventrees
//                params[@"mobile"] = [NSString stringWithFormat:@"%@,%lu", self.registerModel.phoneNumber, operationBrand];
//                params[@"code"] = self.loginModel.verifyCode;
//                params[@"password"] = @"123456";
//                [NetworkMgr POST:kRegisterURIPath params:params success:^(NetworkResultModel *resultModel) {
//                    [subscriber sendNext:resultModel];
//                    [subscriber sendCompleted];
//                    DLog(@"resultModel == %@", resultModel);
//                    
//                } failure:^(NSError *error) {
//                    [subscriber sendCompleted];
//                }];
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

- (RACSubject *)loginSuccessSubject {
    if (! _loginSuccessSubject) {
        _loginSuccessSubject = [RACSubject subject];
    }
    return _loginSuccessSubject;
}

- (RACSubject *)registerActionSubject {
    if (! _registerActionSubject) {
        _registerActionSubject = [RACSubject subject];
    }
    return _registerActionSubject;
}

- (FMLoginModel *)loginModel {
    if (! _loginModel) {
        _loginModel = [[FMLoginModel alloc] init];
    }
    return _loginModel;
}

@end
