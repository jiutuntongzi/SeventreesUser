//
//  FMScoreViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreViewModel.h"

@implementation FMScoreViewModel

- (RACSubject *)nextActionSubject {
    if (!_nextActionSubject) {
        _nextActionSubject = [[RACSubject alloc] init];
    }
    return _nextActionSubject;
}

@end
