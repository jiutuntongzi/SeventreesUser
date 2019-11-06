//
//  FMVerifyInputViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMVerifyInputViewModel : FMViewModel

@property (nonatomic, copy) NSString *verifyCodeText;

@property (nonatomic, strong) RACSubject *verifyActionSubject;

@property (nonatomic, strong) RACSubject *textChangeSubject;


@property (nonatomic, copy) NSString *bodyPhoneNumber;

@property (nonatomic, strong) RACCommand *requestVerifyCodeCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end
