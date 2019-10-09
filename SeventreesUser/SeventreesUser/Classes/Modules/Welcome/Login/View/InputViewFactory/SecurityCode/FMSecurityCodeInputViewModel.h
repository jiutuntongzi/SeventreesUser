//
//  FMSecurityCodeInputViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMSecurityCodeInputViewModel : FMViewModel

/** 输入的验证码 */
@property (nonatomic, copy) NSString *verifyCode;

/** 获取验证码 */
@property (nonatomic, strong) RACSubject *sendActionSubject;

/** 输入验证码文本变化 */
@property (nonatomic, strong) RACSubject *textChangedSubject;

@end
