//
//  FMStoreCheckViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreCheckViewModel.h"

@implementation FMStoreCheckViewModel

- (RACSubject *)checkActionSubject {
    if (! _checkActionSubject) {
        _checkActionSubject = [[RACSubject alloc] init];
    }
    return _checkActionSubject;
}

- (RACSubject *)addressActionSubject {
    if (! _addressActionSubject) {
        _addressActionSubject = [[RACSubject alloc] init];
    }
    return _addressActionSubject;
}

- (RACSubject *)telephoneActionSubject {
    if (! _telephoneActionSubject) {
        _telephoneActionSubject = [[RACSubject alloc] init];
    }
    return _telephoneActionSubject;
}

@end
