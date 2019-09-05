//
//  FMGoodsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsViewModel.h"

@implementation FMGoodsViewModel

- (RACSubject *)addActionSubject {
    if (!_addActionSubject) {
        _addActionSubject = [[RACSubject alloc] init];
    }
    return _addActionSubject;
}

- (RACSubject *)selectActionSubject {
    if (!_selectActionSubject) {
        _selectActionSubject = [[RACSubject alloc] init];
    }
    return _selectActionSubject;
}

@end
