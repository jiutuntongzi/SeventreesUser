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

- (void)setStatus:(FMRefundStatusViewStyle)status {
    _status = status;
    
//    FMRefundStatusViewStyleRefunding,        // 退款中
//    FMRefundStatusViewStyleWaitSend,         // 审核通过，待用户发货
//    FMRefundStatusViewStyleWaitReceive,      // 审核通过，待商家验收
//    FMRefundStatusViewStyleRefundFailure,    // 退款失败
//    FMRefundStatusViewStyleSalesFailure,     // 退货失败
//    FMRefundStatusViewStyleRefundSuccess,    // 退款成功
//    FMRefundStatusViewStyleSalesSuccess,     // 退货成功
    
    if (status == FMRefundStatusViewStyleRefunding) {
        _statusLabel.text = @"退款审核中";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refunding");
        _timeLabel.text = @"还剩1小时32分钟"; // test
        
    } else if (status == FMRefundStatusViewStyleWaitSend) {
        _statusLabel.text = @"审核通过，待用户发货";
//        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_waitSend");
        _timeLabel.text = @"2019-05-23  15:59:23"; // test
        
    } else if (status == FMRefundStatusViewStyleWaitReceive) {
        _statusLabel.text = @"审核通过，待商家验收";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_waitReceive");
        _timeLabel.text = @"2019-05-23  15:59:23"; // test
        
    } else if (status == FMRefundStatusViewStyleRefundFailure) {
        _statusLabel.text = @"退款失败";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundFailure");
        _timeLabel.text = @"2019-05-23  15:59:23"; // test

    } else if (status == FMRefundStatusViewStyleSalesFailure) {
        _statusLabel.text = @"退货失败";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundFailure");
        _timeLabel.text = @"2019-05-23  15:59:23"; // test
        
    } else if (status == FMRefundStatusViewStyleRefundSuccess) {
        _statusLabel.text = @"退款成功";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundSuccess");
        _timeLabel.text = @"2019-05-23  15:59:23"; // test
        
    } else if (status == FMRefundStatusViewStyleSalesSuccess) {
        _statusLabel.text = @"退货成功";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundSuccess");
        _timeLabel.text = @"2019-05-23  15:59:23"; // test
    }
}

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
