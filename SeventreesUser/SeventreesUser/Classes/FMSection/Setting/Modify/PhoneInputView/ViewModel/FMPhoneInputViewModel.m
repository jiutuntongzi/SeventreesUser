//
//  FMPhoneInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPhoneInputViewModel.h"

@implementation FMPhoneInputViewModel

- (RACSubject *)textChangeSubject {
    if (! _textChangeSubject) {
        _textChangeSubject = [[RACSubject alloc] init];
    }
    return _textChangeSubject;
}

@end
