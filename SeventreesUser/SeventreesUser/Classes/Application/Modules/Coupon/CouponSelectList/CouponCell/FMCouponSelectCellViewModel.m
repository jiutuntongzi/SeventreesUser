//
//  FMCouponSelectCellViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponSelectCellViewModel.h"

@implementation FMCouponSelectCellViewModel

- (RACSubject *)checkedActionSubject {
    if (! _checkedActionSubject) {
        _checkedActionSubject = [RACSubject subject];
    }
    return _checkedActionSubject;
}

@end
