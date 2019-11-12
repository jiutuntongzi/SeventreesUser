//
//  FMCouponCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponCell.h"

@interface FMCouponCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topStyleImgView;
@property (weak, nonatomic) IBOutlet UIImageView *couponTypeImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *remakeLabel;

@property (weak, nonatomic) IBOutlet UIButton *takeButton;
@property (weak, nonatomic) IBOutlet UIImageView *couponUsedImgView;

@end

@implementation FMCouponCell

- (void)fm_setupSubviews {
    _takeButton.layer.cornerRadius = 13.f;
    _takeButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _takeButton.layer.borderWidth = 1.f;
    
    self.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, viewModel.couponEntity) subscribeNext:^(FMCouponModel *couponEntity) {
        @strongify(self)    if (!self) return;
        
        self->_timeLimitLabel.text = [NSString stringWithFormat:@"使用期限：%@至%@", couponEntity.startTime, couponEntity.endTime];
        self->_remakeLabel.text = couponEntity.remake ?: @"--"; // 备注
        
        /// 券金额标题
        CGFloat couponMoney = couponEntity.amount.floatValue; // 默认优惠卷
        if (couponEntity.type.integerValue == 2) { // 2 = 折扣卷
            couponMoney = couponEntity.discount.floatValue;
        }
        self->_titleLabel.text = [NSString stringWithFormat:@"%.2f元%@", couponMoney, couponEntity.name];
        
        /// 优惠卷类型（1 = 现金卷 2 = 折扣卷）
        NSString *typeImageName = nil, *styleImageName = nil;
        switch (couponEntity.type.integerValue) {
            case 1: {
                styleImageName = @"icon_cashCoupon_top";
                typeImageName = @"icon_cashCoupon";
                break;
            }
            case 2: {
                styleImageName = @"icon_ciscountsCoupon_top";
                typeImageName = @"icon_ciscountsCoupon";
                break;
            }
            case 3: {
                styleImageName = @"icon_presentCoupon_top";
                typeImageName = @"icon_presentCoupon";
                break;
            }
            case 4: {
                styleImageName = @"icon_welfareCoupon_top";
                typeImageName = @"icon_welfareCoupon";
                break;
            }
            default:
                break;
        }

        /// 优惠卷状态 1 = 未领取, 2 = 未使用, 3 = 已使用
        if (couponEntity.status == 1 || couponEntity.status == 2) {
            self->_topStyleImgView.image = UIImage.ci_imageNamed(styleImageName);
            self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
            
            self->_takeButton.hidden = NO;
            self->_couponUsedImgView.hidden = YES;
            
        } else if (couponEntity.status == 3) {
            self->_topStyleImgView.image = UIImage.ci_imageNamed(@"icon_cashCoupon_top_used");
            self->_couponTypeImgView.image = UIImage.ci_imageNamed(@"icon_cashCoupon_used");
            
            self->_takeButton.hidden = YES;
            self->_couponUsedImgView.hidden = NO;
            
        } else {
            self->_takeButton.hidden = NO;
            self->_couponUsedImgView.hidden = YES;
            DLog(@"优惠卷状态nil：couponEntity.status == %ld", couponEntity.status);
        }
    }];
}

- (void)setViewModel:(FMCouponCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    @weakify(self)
    [[_takeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *takeButton) {
        @strongify(self)    if (!self) return;
        [self->_viewModel.requestDataCommand execute:nil];
    }];
    
    [self->_viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
    }];
}

@end
