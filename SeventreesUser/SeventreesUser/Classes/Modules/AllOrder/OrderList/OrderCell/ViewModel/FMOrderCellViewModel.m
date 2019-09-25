//
//  FMOrderCellViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderCellViewModel.h"

@implementation FMOrderCellViewModel

- (RACSubject *)leftActionSubject {
    if (!_leftActionSubject) {
        _leftActionSubject = [[RACSubject alloc] init];
    }
    return _leftActionSubject;
}

- (RACSubject *)rightActionSubject {
    if (!_rightActionSubject) {
        _rightActionSubject = [[RACSubject alloc] init];
    }
    return _rightActionSubject;
}

@end
