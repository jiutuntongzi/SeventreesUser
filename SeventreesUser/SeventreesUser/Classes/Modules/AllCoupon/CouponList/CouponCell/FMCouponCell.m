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

@end

@implementation FMCouponCell

- (void)fm_setupSubviews {
    _takeButton.layer.cornerRadius = 13.f;
    _takeButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _takeButton.layer.borderWidth = 1.f;
}

- (void)fm_bindViewModel {
    @weakify(self)
    [RACObserve(self, viewModel.couponEntity) subscribeNext:^(FMCouponModel *couponEntity) {
        @strongify(self)    if (!self) return;
        
        
        
        /// 优惠卷类型（1 = 现金卷 2 = 折扣卷）
        NSString *typeImageName, *styleImageName;
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
        
        // 优惠卷状态 1 = 未领取, 2 = 未使用, 3 = 已使用
        if (couponEntity.status == 1) {
            self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
            
        } else if (couponEntity.status == 2) {
            typeImageName = [NSString stringWithFormat:@"%@_notuse", typeImageName];
            self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
            
        } else if (couponEntity.status == 3) {
            typeImageName = [NSString stringWithFormat:@"%@_used", typeImageName];
            self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
        } else {
            DLog(@"优惠卷状态未定义：couponEntity.status == %ld", couponEntity.status);
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
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
}

@end
