//
//  FMCollectionViewCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectionViewCell.h"

@implementation FMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
