//
//  FMHomeMenuViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeMenuViewModel.h"

@implementation FMHomeMenuViewModel

- (RACSubject *)itemActionSubject {
    if (! _itemActionSubject) {
        _itemActionSubject = [RACSubject subject];
    }
    return _itemActionSubject;
}

@end
