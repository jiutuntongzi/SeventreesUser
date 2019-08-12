//
//  FMView.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMView.h"

@implementation FMView

- (instancetype)init {
    if (self = [super init]) {
        [self fm_setupSubviews];
        [self fm_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    if (self = [super init]) {
        [self fm_setupSubviews];
        [self fm_bindViewModel];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self fm_setupSubviews];
    [self fm_bindViewModel];
}

/** 设置子views */
- (void)fm_setupSubviews { /** Subclass overwrite */ };
/** 绑定ViewModel */
- (void)fm_bindViewModel { /** Subclass overwrite */ };

@end
