//
//  FMVerifyInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMVerifyInputViewModel.h"

@implementation FMVerifyInputViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestVerifyCodeCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (RACCommand *)requestVerifyCodeCommand {
    if (! _requestVerifyCodeCommand) {
        @weakify(self)
        _requestVerifyCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
                // 运营品牌 1：Seventrees
                params[@"mobile"] = [NSString stringWithFormat:@"%@,%lu", self->_bodyPhoneNumber, operationBrand];
                // 申请验证码类型（login 登录验证码[默认]，register 注册验证码，pwd 找回密码验证码）
                params[@"type"] = @"login";
                
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

- (RACSubject *)verifyActionSubject {
    if (! _verifyActionSubject) {
        _verifyActionSubject = [[RACSubject alloc] init];
    }
    return _verifyActionSubject;
}

- (RACSubject *)textChangeSubject {
    if (! _textChangeSubject) {
        _textChangeSubject = [[RACSubject alloc] init];
    }
    return _textChangeSubject;
}

@end
