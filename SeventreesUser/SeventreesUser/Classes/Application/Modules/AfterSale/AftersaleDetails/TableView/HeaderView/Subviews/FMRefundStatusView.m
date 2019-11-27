//
//  FMRefundStatusView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundStatusView.h"
#import "DialogBoxView.h"

@interface FMRefundStatusView ()

/** 售后状态(0等待处理,1审核不通过,2审核通过（退货中未填写物流）,3审核通过（退款中/退货中已填写物流）,5退款成功,4商家已验收 */
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
        
    } else if (status == FMRefundStatusViewStyleWaitSend) {
        _statusLabel.text = @"审核通过，待用户发货";
//        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_waitSend");
        [self hiddenImgStatus:YES];
        
    } else if (status == FMRefundStatusViewStyleWaitReceive) {
        _statusLabel.text = @"审核通过，待商家验收";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_waitReceive");
        
    } else if (status == FMRefundStatusViewStyleRefundFailure) {
        _statusLabel.text = @"退款失败";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundFailure");

    } else if (status == FMRefundStatusViewStyleSalesFailure) {
        _statusLabel.text = @"退货失败";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundFailure");
        
    } else if (status == FMRefundStatusViewStyleRefundSuccess) {
        _statusLabel.text = @"退款成功";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundSuccess");
        
    } else if (status == FMRefundStatusViewStyleSalesSuccess) {
        _statusLabel.text = @"退货成功";
        _statusImgView.image = UIImage.ci_imageNamed(@"icon_afterSale_refundSuccess");
    }
}

- (void)hiddenImgStatus:(BOOL)isHidden {
    _statusImgView.hidden = isHidden;
    _shipmentsButton.hidden = !isHidden;
}

- (void)fm_setupSubviews {
    self.cv_backColorByHexString(@"#F76F6F");
    _shipmentsButton.layer.cornerRadius = 3.f;
    _shipmentsButton.layer.borderColor = UIColor.whiteColor.CGColor;
    _shipmentsButton.layer.borderWidth = 1.f;
    
    [self hiddenImgStatus:NO];
}

- (void)fm_bindObserver {
    @weakify(self)
    
    [RACObserve(self, statusTime) subscribeNext:^(NSString *statusTime) {
        @strongify(self)
        if (self->_status != FMRefundStatusViewStyleRefunding) {
            self->_timeLabel.text = statusTime ?: @"--";
        }
    }];
    
    [RACObserve(self, remainTime) subscribeNext:^(NSNumber *remainTime) {
        @strongify(self)
        if (self->_status == FMRefundStatusViewStyleRefunding) {
//            [NSString stringWithFormat:@"", ]
            self->_timeLabel.text = remainTime.stringValue; // test
//            self->_timeLabel.text = @"还剩1小时32分钟"; // test
        }
        
    }];
}

- (void)fm_bindViewModel {
    [[_shipmentsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [DialogBoxView showByTitle:@"请填写发货信息" message:@"" affirmButtonTitle:@"确定" forStyle:DialogBoxViewStyleInput affirmHandler:^(NSString * _Nullable text) {
            
        }];
    }];
}

@end
