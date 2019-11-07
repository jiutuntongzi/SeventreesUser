//
//  FMSettingViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettingViewModel.h"

@implementation FMSettingViewModel

- (RACSubject *)logoutActionSubject {
    if (!_logoutActionSubject) {
        _logoutActionSubject = [[RACSubject alloc] init];
    }
    return _logoutActionSubject;
}

@end
