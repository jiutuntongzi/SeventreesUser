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

@end
