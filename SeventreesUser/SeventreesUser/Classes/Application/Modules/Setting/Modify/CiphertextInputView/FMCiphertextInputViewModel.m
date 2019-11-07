//
//  FMCiphertextInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCiphertextInputViewModel.h"

@implementation FMCiphertextInputViewModel

- (RACSubject *)plaintextTouchSubject {
    if (!_plaintextTouchSubject) {
        _plaintextTouchSubject = [[RACSubject alloc] init];
    }
    return _plaintextTouchSubject;
}

- (RACSubject *)textChangedSubject {
    if (! _textChangedSubject) {
        _textChangedSubject = [[RACSubject alloc] init];
    }
    return _textChangedSubject;
}

@end
