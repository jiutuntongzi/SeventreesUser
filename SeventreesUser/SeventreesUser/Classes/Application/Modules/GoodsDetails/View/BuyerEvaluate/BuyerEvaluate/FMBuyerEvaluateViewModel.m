//
//  FMBuyerEvaluateViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBuyerEvaluateViewModel.h"

@implementation FMBuyerEvaluateViewModel

- (RACSubject *)nextActionSubject {
    if (! _nextActionSubject) {
        _nextActionSubject = [[RACSubject alloc] init];
    }
    return _nextActionSubject;
}

- (RACSubject *)selectItemSubject {
    if (! _selectItemSubject) {
        _selectItemSubject = [[RACSubject alloc] init];
    }
    return _selectItemSubject;
}

@end
