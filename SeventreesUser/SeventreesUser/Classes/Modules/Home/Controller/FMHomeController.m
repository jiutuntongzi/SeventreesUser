//
//  FMHomeController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeController.h"
#import "SearchBarView.h"
#import "FMHomeView.h"

@interface FMHomeController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *viewModel;

@end

@implementation FMHomeController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViewConstraints {
    _mainView.cv_frame(self.view.bounds);
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    FMHomeView *homeView = FMHomeView.cv_viewFromNibLoad();
    _mainView = homeView;
    [self.view addSubview:homeView];
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
