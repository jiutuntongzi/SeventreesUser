//
//  FMCollectController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectController.h"

@interface FMCollectController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *viewModel;

@end

@implementation FMCollectController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.cv_backColor(UIColor.greenColor);
}

- (void)updateViewConstraints {
//    _mainView.cv_frame(self.view.bounds);
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
//    FMHomeView *mainView = FMHomeView.cv_viewFromNibLoad();
//    _mainView = mainView;
//    [self.view addSubview:mainView];
    
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
