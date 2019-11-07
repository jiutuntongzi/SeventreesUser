//
//  FMMemberCenterController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMemberCenterController.h"

#import "FMMemberCenterView.h"
#import "FMMemberCenterViewModel.h"

@interface FMMemberCenterController ()

@property (nonatomic, strong) FMMemberCenterView *mainView;

@end

@implementation FMMemberCenterController

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
    _mainView = [[FMMemberCenterView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [_mainView.viewModel.nextActionSubject subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
//        UIViewController *nextVC = [[FMAddressManagerController alloc] init];
//        self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"会员中心";
    
//    __weak typeof(self) weakSelf = self;
//    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
//        DLog(@"点了导航栏右");
//        UIViewController *nextVC = [[FMFeedbackController alloc] init];
//        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
//    });
//    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

@end
