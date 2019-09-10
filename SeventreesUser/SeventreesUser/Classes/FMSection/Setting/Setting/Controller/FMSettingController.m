//
//  FMSettingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettingController.h"

#import "FMFeedbackController.h"

#import "FMSettingView.h"
#import "FMSettingViewModel.h"

@interface FMSettingController ()

@property (nonatomic, strong) FMSettingView *mainView;

@end

@implementation FMSettingController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMSettingView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"设置";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        DLog(@"点了导航栏右");
        UIViewController *nextVC = [[FMFeedbackController alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
