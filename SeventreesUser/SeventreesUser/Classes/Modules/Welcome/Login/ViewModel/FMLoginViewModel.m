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
                DLog(@"self.loginModel == %@", self.loginModel);
                // 网络请求
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/book/search?q=%22%E7%BE%8E%E5%A5%B3%22"]];
                [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                        [subscriber sendNext:resultDictionary];
                        [subscriber sendCompleted];
                    });
                }] resume];
                
                /*
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/login"]];
                request.HTTPMethod = @"POST";
                NSString *paramString = [NSString stringWithFormat:@"username=%@&pwd=%@&type=JSON", self.loginModel.account, self.loginModel.password];
                NSData *paramData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
                request.HTTPBody = paramData;
                [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSDictionary *resultDictionary = nil;
                    if (data) resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
                    
                    [subscriber sendNext:resultDictionary];
                    [subscriber sendCompleted];
                }] resume];
                */
                return [RACDisposable disposableWithBlock:^{
                    DLog(@"资源被清理了");
                }];
                 
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
