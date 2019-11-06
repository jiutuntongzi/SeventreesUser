//
//  FMInputModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMInputModel : FMModel

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *twoPhoneNumber;

@property (nonatomic, copy) NSString *verifyCode;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *bindPhoneNumber;

@end

