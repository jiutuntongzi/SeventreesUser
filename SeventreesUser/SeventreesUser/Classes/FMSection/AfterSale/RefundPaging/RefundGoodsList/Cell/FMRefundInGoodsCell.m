//
//  FMRefundInGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundInGoodsCell.h"

@interface FMRefundInGoodsCell ()

@property (weak, nonatomic) IBOutlet UIButton *detailsButton;

@end

@implementation FMRefundInGoodsCell

- (void)fm_setupSubviews {
    _detailsButton.layer.cornerRadius = 15.f;
    _detailsButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _detailsButton.layer.borderWidth = 1.f;
    
}

- (void)fm_bindViewModel {
    
}

@end
