//
//  FMMeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMeView.h"

#import "FMBargainTypeController.h"
#import "FMSpellGroupController.h"
#import "FMSettingController.h"
#import "FMPersonalProfileController.h"

@interface FMMeView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopMarginCons;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIView *totalContentView;

@property (weak, nonatomic) IBOutlet UIButton *spellButton;
@property (weak, nonatomic) IBOutlet UIButton *bargainButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *myQRCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

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
    __weak typeof(self) weakSelf = self;
    _headImgView.cv_addTouchEventCallback(^(UIImageView *imageView) {
        UIViewController *nextVC = [[FMPersonalProfileController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        weakSelf.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    
    @weakify(self);
    
    [[_settingButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        UIViewController *nextVC = [[FMSettingController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_spellButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // test
        UIViewController *nextVC = [[FMSpellGroupController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_bargainButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // test
        UIViewController *nextVC = [[FMBargainTypeController alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [[_collectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
    }];
};

@end
