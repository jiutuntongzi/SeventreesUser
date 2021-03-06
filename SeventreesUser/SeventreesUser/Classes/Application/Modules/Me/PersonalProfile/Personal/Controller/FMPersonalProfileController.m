//
//  FMPersonalProfileController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPersonalProfileController.h"
#import "FMPersonalProfileView.h"

#import "FMAddressManagerController.h"

@interface FMPersonalProfileController ()

@property (nonatomic, strong) FMPersonalProfileView *mainView;

@end

@implementation FMPersonalProfileController

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
    _mainView = [[FMPersonalProfileView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [_mainView.viewModel.showAddressVCSubject subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        FMAddressManagerController *nextVC = [[FMAddressManagerController alloc] init];
        self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"个人资料";
    
//    __weak typeof(self) weakSelf = self;
//    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
//        DLog(@"点了导航栏右");
//        UIViewController *nextVC = [[FMFeedbackController alloc] init];
//        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
//    });
//    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
    [_mainView.viewModel.requestDataCommand execute:nil];
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
