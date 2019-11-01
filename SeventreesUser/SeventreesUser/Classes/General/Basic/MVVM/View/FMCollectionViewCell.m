//
//  FMCollectionViewCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectionViewCell.h"

@implementation FMCollectionViewCell

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    if (self = [super init]) {
        [self bindMVVMModulars];
    }
    return self;
}


//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        [self bindMVVMModulars];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self bindMVVMModulars];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self bindMVVMModulars];
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
