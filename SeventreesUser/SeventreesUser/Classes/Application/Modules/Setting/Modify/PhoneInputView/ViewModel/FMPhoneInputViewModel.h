//
//  FMPhoneInputViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMPhoneInputViewModel : FMViewModel

@property (nonatomic, copy) NSString *placeholderText; // set

@property (nonatomic, copy) NSString *numberText; // get

@property (nonatomic, strong) RACSubject *textChangeSubject;

@end
