//
//  FMSettlementViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettlementViewModel.h"

@implementation FMSettlementViewModel

- (RACSubject *)checkAllActionSubject {
    if (!_checkAllActionSubject) {
        _checkAllActionSubject = [[RACSubject alloc] init];
    }
    return _checkAllActionSubject;
}

- (RACSubject *)settleActionSubject {
    if (!_settleActionSubject) {
        _settleActionSubject = [[RACSubject alloc] init];
    }
    return _settleActionSubject;
}

@end
