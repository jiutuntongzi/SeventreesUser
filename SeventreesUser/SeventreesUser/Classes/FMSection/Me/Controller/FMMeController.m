//
//  FMMeController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMeController.h"
#import "FMMeView.h"

@interface FMMeController ()

@property (nonatomic, strong) UIView *mainView;

@end

@implementation FMMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)updateViewConstraints {
    _mainView.cv_frame(self.view.bounds);
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    FMMeView *meView = FMMeView.cv_viewFromNibLoad();
    _mainView = meView;
    [self.view addSubview:meView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"首页";
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload



@end
