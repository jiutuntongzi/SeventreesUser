//
//  FMSecurityCodeInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSecurityCodeInputViewModel.h"

@implementation FMSecurityCodeInputViewModel

- (RACSubject *)sendActionSubject {
    if (!_sendActionSubject) {
        _sendActionSubject = [[RACSubject alloc] init];
    }
    return _sendActionSubject;
}

- (RACSubject *)textChangedSubject {
    if (!_textChangedSubject) {
        _textChangedSubject = [[RACSubject alloc] init];
    }
    return _textChangedSubject;
}

@end
