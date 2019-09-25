//
//  FMVerifyInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMVerifyInputViewModel.h"

@implementation FMVerifyInputViewModel

- (RACSubject *)verifyActionSubject {
    if (! _verifyActionSubject) {
        _verifyActionSubject = [[RACSubject alloc] init];
    }
    return _verifyActionSubject;
}

@end
