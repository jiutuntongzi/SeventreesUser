//
//  FMStoreIntroViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreIntroViewModel.h"

@implementation FMStoreIntroViewModel

- (void)fm_initialize {
    
}

#pragma mark - Lazyload

- (RACSubject *)actionSubject {
    if (!_actionSubject) {
        _actionSubject = [[RACSubject alloc] init];
    }
    return _actionSubject;
}

@end
