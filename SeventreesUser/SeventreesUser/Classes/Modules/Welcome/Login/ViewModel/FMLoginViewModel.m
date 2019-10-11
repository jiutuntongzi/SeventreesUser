//
//  FMLoginViewModel.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMLoginViewModel.h"

#import "NetworkDataConver.h"

@implementation FMLoginViewModel

- (void)fm_initialize {
    @weakify(self)

    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:resultModel];
        
        if ([resultModel.statusCode isEqualToString:@"OK"]) {
            userData().phoneNumber = self.loginModel.phoneNumber;
            [self.loginSuccessSubject sendNext:resultModel];
        }
    }];
    
    [self.requestVerifyCodeCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:resultModel];
    }];
    
//    self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self.loginModel, phoneNumber), RACObserve(self.loginModel, password)] reduce:^id (NSString *phoneNumber, NSString *password) {
//        return @(phoneNumber.length == 11 && password.length);
//    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (!_requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                /*
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
                // 运营品牌 1：Seventrees
                params[@"username"] = [NSString stringWithFormat:@"%@,%lu", self.loginModel.phoneNumber, operationBrand];
                if (self.loginModel.verifyCode.length) params[@"code"] = self.loginModel.verifyCode;
                if (self.loginModel.password.length) params[@"password"] = self.loginModel.password;
                */
                
                /*
                NSString *username = [NSString stringWithFormat:@"%@,%lu", self.loginModel.phoneNumber, operationBrand];
                
                NSString *loginURIPath = @"";
                if (self.loginModel.verifyCode.length) {
                    loginURIPath = [NSString stringWithFormat:@"%@?username=%@&code=%@", kLoginURIPath, username, self.loginModel.verifyCode];
                } else if (self.loginModel.password.length) {
                    loginURIPath = [NSString stringWithFormat:@"%@?username=%@&password=%@", kLoginURIPath, username, self.loginModel.password];
                } else {
                    DLog(@"GET登录拼接URL失败!!!");
                }
                
                [networkMgr GET:loginURIPath parameters:nil success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                */
                
                NSString *username = [NSString stringWithFormat:@"%@,%lu", self.loginModel.phoneNumber, operationBrand];
                
                NSString *loginURIPath = @"";
                if (self.loginModel.verifyCode.length) {
                    loginURIPath = [NSString stringWithFormat:@"%@?username=%@&code=%@", kLoginURIPath, username, self.loginModel.verifyCode];
                } else if (self.loginModel.password.length) {
                    loginURIPath = [NSString stringWithFormat:@"%@?username=%@&password=%@", kLoginURIPath, username, self.loginModel.password];
                } else {
                    DLog(@"登录拼接URLPath失败!!!");
                }
                
                NSString *domain = @"http://192.168.1.135:8080";
                NSString *URLString = [domain stringByAppendingString:loginURIPath];
                DLog(@"（NSURLSession）原生登录POST请求:URLString == %@", URLString);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
                request.HTTPMethod = @"POST";
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                
                [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NetworkResultModel *resultModel;
                        if (data) {
                            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
                             resultModel = [NetworkDataConver resultModelFromAFNetworkingResponseObject:resultDict];
                        }
                        DLog(@"登录结果resultDict == %@", resultModel);
                        [subscriber sendNext:resultModel];
                        [subscriber sendCompleted];
                    });
                }] resume];
                
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
                params[@"mobile"] = [NSString stringWithFormat:@"%@,%lu", self.loginModel.phoneNumber, operationBrand];
                // 申请验证码类型（login 登录验证码[默认]，register 注册验证码，pwd 找回密码验证码）
                params[@"type"] = @"login";
                
                [networkMgr POST:kSendVerifyCodeURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
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

- (RACSubject *)agreementActionSubject {
    if (! _agreementActionSubject) {
        _agreementActionSubject = [RACSubject subject];
    }
    return _agreementActionSubject;
}

- (FMLoginModel *)loginModel {
    if (! _loginModel) {
        _loginModel = [[FMLoginModel alloc] init];
    }
    return _loginModel;
}

@end
