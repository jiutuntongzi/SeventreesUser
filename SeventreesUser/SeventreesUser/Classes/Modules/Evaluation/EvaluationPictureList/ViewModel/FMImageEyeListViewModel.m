//
//  FMImageEyeListViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMImageEyeListViewModel.h"

@implementation FMImageEyeListViewModel

- (RACSubject *)selectItemSubject {
    if (! _selectItemSubject) {
        _selectItemSubject = [[RACSubject alloc] init];
    }
    return _selectItemSubject;
}

@end
