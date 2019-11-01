//
//  FMMeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMeView.h"

#import "FMBargainTypeController.h"
#import "FMSlashPagingController.h"
#import "FMSpellGroupPagingController.h"
//#import "FMSpellListController.h"
#import "FMSpellGroupController.h"

#import "FMScoreController.h"
#import "FMCouponPagingController.h"

#import "FMPersonalProfileController.h"
#import "FMMemberCenterController.h"

#import "FMSettingController.h"
#import "FMMessageListController.h"
#import "FMVIPQRCodeBoxView.h"

#import "FMOrderPagingController.h"

#import "FMAftersaleDetailsController.h"

#import "FMCollectPagingController.h"
//#import "FMCollectBrandListController.h"


@interface FMMeView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopMarginCons;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIButton *vipButton;
@property (weak, nonatomic) IBOutlet UIView *totalContentView;

@property (weak, nonatomic) IBOutlet UIButton *couponListButton;
@property (weak, nonatomic) IBOutlet UIButton *scoreCenterButton;

@property (weak, nonatomic) IBOutlet UIButton *moreOrderButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *orderTypeButtons;

@property (weak, nonatomic) IBOutlet UIButton *spellButton;
@property (weak, nonatomic) IBOutlet UIButton *bargainButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *myQRCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@property (weak, nonatomic) IBOutlet UILabel *delayPaymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *delayDeliverLabel;
@property (weak, nonatomic) IBOutlet UILabel *delayTakeLabel;
@property (weak, nonatomic) IBOutlet UILabel *delayCommentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterSaleLabel;

@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreTotalLabel;


@end

@implementation FMMeView

/** 设置子views */
- (void)fm_setupSubviews {
    _headImgView.layer.cornerRadius = 30.f;
    _headImgView.layer.borderWidth = 2.f;
    _headImgView.layer.borderColor = UIColor.whiteColor.CGColor;
    [_headImgView setClipsToBounds:YES];
    
    _totalContentView.layer.shadowColor = [UIColor colorWithRed:13/255.0 green:6/255.0 blue:8/255.0 alpha:0.03].CGColor;
    _totalContentView.layer.shadowOffset = CGSizeMake(0,2);
    _totalContentView.layer.shadowOpacity = 1;
    _totalContentView.layer.shadowRadius = 4;
    _totalContentView.layer.cornerRadius = 5;
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    @weakify(self);
    
    /// Bind Actions
    
    _headImgView.cv_addTouchEventCallback(^(UIImageView *imageView) {
        UIViewController *nextVC = [[FMPersonalProfileController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self_weak_.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    
    [[_vipButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        UIViewController *nextVC = [[FMMemberCenterController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    
    [[_settingButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        UIViewController *nextVC = [[FMSettingController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_myQRCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
        
        [FMVIPQRCodeBoxView showByInfo:nil];
    }];
    
    [[_messageButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        UIViewController *nextVC = [[FMMessageListController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_couponListButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *nextVC = [[FMCouponPagingController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_scoreCenterButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        UIViewController *nextVC = [[FMScoreController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    
    [[_spellButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // test
//        UIViewController *nextVC = [[FMSpellGroupController alloc] init];
        UIViewController *nextVC = [[FMSpellGroupPagingController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_bargainButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // test
//        UIViewController *nextVC = [[FMBargainTypeController alloc] init];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
//
        UIViewController *nextVC = [[FMSlashPagingController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_collectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        UIViewController *nextVC = [[FMCollectPagingController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_moreOrderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // test
//        UIViewController *nextVC = [[FMOrderPagingController alloc] init];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
//        
        // test
        FMAftersaleDetailsController *nextVC = [[FMAftersaleDetailsController alloc] init];
        nextVC.style = FMAftersaleDetailsControllerStyleWaitReceive;
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:nextVC animated:YES];
    }];
    
    for (UInt8 idx = 0; idx != 5; idx++) {
        UIButton *orderTypeButton = _orderTypeButtons[idx];
        orderTypeButton.tag = idx;
       
        [[orderTypeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *orderTypeButton) {
            @strongify(self)
            UIViewController *nextVC = [[FMOrderPagingController alloc] init];
            global_orderType = (unsigned int)orderTypeButton.tag;
            nextVC.hidesBottomBarWhenPushed = YES;
            self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
        }];
    }
    
    /// Bind viewModel
    
    [self.viewModel.refreshUISubject subscribeNext:^(FMMeModel *profileEntity) {
        @strongify(self);
        [self->_headImgView sd_setImageWithURL:[NSURL URLWithString:profileEntity.headUrl] placeholderImage:[UIImage new]];
                self->_nikeNameLabel.text = profileEntity.nick;
        self->_couponTotalLabel.text = [NSString stringWithFormat:@"%@张", profileEntity.couponNum];
        self->_scoreTotalLabel.text = profileEntity.integralNum.stringValue;
        
        self->_delayPaymentLabel.text = [NSString stringWithFormat:@"待付款(%@)", profileEntity.paymentNum.stringValue];
        self->_delayPaymentLabel.text = [NSString stringWithFormat:@"待发货(%@)", profileEntity.deliveryNum.stringValue];
        self->_delayPaymentLabel.text = [NSString stringWithFormat:@"待收货(%@)", profileEntity.takeNum.stringValue];
        self->_delayPaymentLabel.text = [NSString stringWithFormat:@"待评论(%@)", profileEntity.commentsNum.stringValue];
//        self->_afterSaleLabel.text = [NSString stringWithFormat:@"退货/售后(%@)", profileEntity.];
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
    
};

- (FMMeViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMMeViewModel alloc] init];
    }
    return _viewModel;
}

@end
