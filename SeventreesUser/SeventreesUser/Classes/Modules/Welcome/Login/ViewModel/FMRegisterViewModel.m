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

    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
        [self.refreshUISubject sendNext:x]; // 登录成功发UI信号
        [self.registerSuccessSubject sendNext:x]; // 登录成功
    }];
    
//    [[self.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
//        if ([x isEqualToNumber:@(YES)]) {
//            DLog(@"（命令执行中..）");
//        } else {
//            DLog(@"（命令未开始 / 命令执行完成");
//        }
//    }];
    
//    self.registerEnableSignal = [RACSignal combineLatest:@[RACObserve(self.registerModel, phoneNumber), RACObserve(self.registerModel, verifyCode)] reduce:^id (NSString *account, NSString *password) {
//        return @(account.length == 11 && password.length);
//    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (!_requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                DLog(@"self.registerModel == %@", self.registerModel);
                // 请求体参数
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
                params[@"mobile"] = self.registerModel.phoneNumber;
                params[@"code"] = self.registerModel.verifyCode;
                params[@"password"] = @"123456";
                [NetworkMgr POST:kRegisterURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)registerSuccessSubject {
    if (!_registerSuccessSubject) {
        _registerSuccessSubject = [RACSubject subject];
    }
    return _registerSuccessSubject;
}

- (FMRegisterModel *)registerModel {
    if (!_registerModel) {
        _registerModel = [[FMRegisterModel alloc] init];
    }
    return _registerModel;
}

@end
