//
//  FMCouponSelectCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponSelectCell.h"

@interface FMCouponSelectCell ()

@property (weak, nonatomic) IBOutlet UIImageView *topStyleImgView;
@property (weak, nonatomic) IBOutlet UIImageView *couponTypeImgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLimitLabel;
@property (weak, nonatomic) IBOutlet UILabel *remakeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *checkedImgView;
@property (weak, nonatomic) IBOutlet UIButton *checkedButton;

@end

@implementation FMCouponSelectCell

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, viewModel.couponEntity) subscribeNext:^(FMCouponSelectModel *couponEntity) {
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
        if (couponEntity.status == 2) {
            self->_topStyleImgView.image = UIImage.ci_imageNamed(styleImageName);
            self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
            
        } else {
            DLog(@"优惠卷状态nil：couponEntity.status == %ld", couponEntity.status);
        }
        
        /*
         /// 优惠卷状态 1 = 未领取, 2 = 未使用, 3 = 已使用
         if (couponEntity.status == 1) {
         self->_topStyleImgView.image = UIImage.ci_imageNamed(styleImageName);
         self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
         
         } else if (couponEntity.status == 2) {
         self->_topStyleImgView.image = UIImage.ci_imageNamed(styleImageName);
         self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
         
         } else if (couponEntity.status == 3) {
         styleImageName = [NSString stringWithFormat:@"%@_used", styleImageName];
         self->_topStyleImgView.image = UIImage.ci_imageNamed(styleImageName);
         
         typeImageName = [NSString stringWithFormat:@"%@_used", typeImageName];
         self->_couponTypeImgView.image = UIImage.ci_imageNamed(typeImageName);
         } else {
         DLog(@"优惠卷状态nil：couponEntity.status == %ld", couponEntity.status);
         }
         */
    }];
    
    [[self rac_valuesForKeyPath:@"viewModel.couponEntity.isChecked" observer:nil] subscribeNext:^(NSNumber * _Nullable isChecked) {
        @strongify(self)    if (!self) return;
        if (isChecked.boolValue) {
            self->_checkedImgView.image = UIImage.ci_imageNamed(@"icon_coupon_selected");
        } else {
            self->_checkedImgView.image = UIImage.ci_imageNamed(@"icon_coupon_normal");
        }
    }];
}

- (void)setViewModel:(FMCouponSelectCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    @weakify(self)
    [[_checkedButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *takeButton) {
        @strongify(self)
        [self->_viewModel.checkedActionSubject sendNext:viewModel.couponEntity];
    }];
}

@end
