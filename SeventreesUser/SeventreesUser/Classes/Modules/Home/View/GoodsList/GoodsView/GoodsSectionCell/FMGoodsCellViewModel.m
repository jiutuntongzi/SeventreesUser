//
//  FMGoodsCellViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsCellViewModel.h"

@implementation FMGoodsCellViewModel

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
