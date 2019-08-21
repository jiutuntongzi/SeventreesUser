//
//  FMGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsCell.h"

#import "MacroHeader.h"

@interface FMGoodsCell ()

@property (weak, nonatomic) IBOutlet UIButton *shoppingCarButton;

@end

@implementation FMGoodsCell

/** 设置子views */
- (void)fm_setupSubviews {
    
    
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    
    [[_shoppingCarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        DLog(@"button == %@", button);
    }];
};

@end
