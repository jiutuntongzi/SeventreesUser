//
//  FMStoreViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreViewModel.h"

@implementation FMStoreViewModel

- (RACSubject *)chatActionSubject {
    if (! _chatActionSubject) {
        _chatActionSubject = [RACSubject subject];
    }
    return _chatActionSubject;
}

@end
