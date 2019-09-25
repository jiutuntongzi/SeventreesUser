//
//  FMRefundStatusView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundStatusView.h"

@interface FMRefundStatusView ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;

@property (weak, nonatomic) IBOutlet UIButton *shipmentsButton;

@end

@implementation FMRefundStatusView

- (void)setStyle:(NSInteger)style {
    _style = style;
    
    BOOL isHidden = style == 1;
    _statusImgView.hidden = isHidden;
    _shipmentsButton.hidden = !isHidden;
}

- (void)fm_setupSubviews {
    self.cv_backColorByHexString(@"#F76F6F");
    _shipmentsButton.layer.cornerRadius = 3.f;
    _shipmentsButton.layer.borderColor = UIColor.whiteColor.CGColor;
    _shipmentsButton.layer.borderWidth = 1.f;
    
    self.style = _style;
}

- (void)fm_bindViewModel {
    
}

@end
