//
//  FMMapNavigationViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMapNavigationViewModel.h"

@implementation FMMapNavigationViewModel

- (RACSubject *)startActionSubject {
    if (! _startActionSubject) {
        _startActionSubject = [[RACSubject alloc] init];
    }
    return _startActionSubject;
}


@end
