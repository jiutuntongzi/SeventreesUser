//
//  FMViewModel.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewModel.h"

@implementation FMViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    FMViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) [viewModel fm_initialize];
    return viewModel;
}

- (void)fm_initialize { }

@end
