//
//  FMStoreLocationController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreLocationController.h"
#import "FMMapNavigationView.h"

@interface FMStoreLocationController ()

@property (nonatomic, strong) FMMapNavigationView *navigationToolView;


@end

@implementation FMStoreLocationController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)updateViewConstraints {
    [_navigationToolView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(8);
        make.right.equalTo(-8);
        make.bottom.equalTo(-10);
        make.height.equalTo(FMMapNavigationViewHeight);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    FMMapNavigationView *navigationToolView = (FMMapNavigationView *)FMMapNavigationView.cv_viewFromNibLoad();
    _navigationToolView = navigationToolView;
    [self.view addSubview:navigationToolView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"位置信息";
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}
@end
