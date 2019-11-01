//
//  FMView.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/15.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMView.h"

@implementation FMView

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    if (self = [super init]) {
        [self bindMVVMModulars];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self bindMVVMModulars];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bindMVVMModulars];
    }
    return self;
}

- (void)bindMVVMModulars {
    [self fm_setupSubviews];
    [self fm_makeConstraints];
    [self fm_bindObserver];
    [self fm_bindViewModel];
}

/** 设置子views */
- (void)fm_setupSubviews { /** Subclass Implement */ };

/** 生成布局约束 */
- (void)fm_makeConstraints { /** Subclass Implement */ };

/** 绑定KVO观察 */
- (void)fm_bindObserver { /** Subclass Implement */ };

/** 绑定ViewModel */
- (void)fm_bindViewModel { /** Subclass Implement */ };

@end
