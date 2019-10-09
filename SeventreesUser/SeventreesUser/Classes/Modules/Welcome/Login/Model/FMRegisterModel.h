//
//  FMRegisterModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMRegisterModel : FMModel

@property (nonatomic, assign) BOOL isAgree;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *verifyCode;

@end
