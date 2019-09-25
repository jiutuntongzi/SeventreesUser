//
//  FMCouponCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponCell.h"

@interface FMCouponCell ()

@property (weak, nonatomic) IBOutlet UIButton *takeButton;

@end

@implementation FMCouponCell

- (void)fm_setupSubviews {
    _takeButton.layer.cornerRadius = 13.f;
    _takeButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _takeButton.layer.borderWidth = 1.f;
}

@end
