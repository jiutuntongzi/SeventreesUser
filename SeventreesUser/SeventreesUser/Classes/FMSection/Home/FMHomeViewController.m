//
//  FMHomeViewController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeViewController.h"

@interface FMHomeViewController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *viewModel;

@end

@implementation FMHomeViewController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateViewConstraints {
    self.mainView.cv_frame(self.view.bounds);
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    
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
