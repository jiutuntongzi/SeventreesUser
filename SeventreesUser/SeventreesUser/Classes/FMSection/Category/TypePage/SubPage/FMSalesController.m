//
//  FMSalesController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSalesController.h"

@interface FMSalesController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *viewModel;

@end

@implementation FMSalesController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.cv_backColor(UIColor.yellowColor);
}

- (void)updateViewConstraints {
//    _mainView.cv_frame(self.view.bounds);
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
//    FMHomeView *homeView = FMHomeView.cv_viewFromNibLoad();
//    _mainView = homeView;
//    [self.view addSubview:homeView];
    
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"SEVEN TREES";
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload

@end
