//
//  FMSettlementViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettlementViewModel.h"

@implementation FMSettlementViewModel

- (void)fm_initialize {
    _isCheckedAll = NO;
    _isEdit = NO;
}

- (RACSubject *)checkAllActionSubject {
    if (! _checkAllActionSubject) {
        _checkAllActionSubject = [[RACSubject alloc] init];
    }
    return _checkAllActionSubject;
}

- (RACSubject *)settleActionSubject {
    if (! _settleActionSubject) {
        _settleActionSubject = [[RACSubject alloc] init];
    }
    return _settleActionSubject;
}

- (RACSubject *)deleteActionSubject {
    if (! _deleteActionSubject) {
        _deleteActionSubject = [[RACSubject alloc] init];
    }
    return _deleteActionSubject;
}

@end
