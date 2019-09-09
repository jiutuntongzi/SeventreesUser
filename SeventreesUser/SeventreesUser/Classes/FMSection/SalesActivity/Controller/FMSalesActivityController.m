//
//  FMSalesActivityController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSalesActivityController.h"

#import "FMSalesActivityView.h"
#import "FMSalesActivityViewModel.h"

@interface FMSalesActivityController ()

@property (nonatomic, strong) FMSalesActivityView *mainView;

@end

@implementation FMSalesActivityController

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
    _mainView = (FMSalesActivityView *)FMSalesActivityView.cv_viewFromNibLoad();
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"拼团专区";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"拼团结果", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMSpellResultController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
    [_mainView.viewModel.refreshUISubject sendNext:nil];
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
