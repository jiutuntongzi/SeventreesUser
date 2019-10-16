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
#import "FMSearchPagingController.h"

@interface FMHomeController ()

@property (nonatomic, strong) FMHomeView *mainView;

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
    [_mainView.viewModel.nextActionSubject subscribeNext:^(NSString *className) {
        UIViewController *nextVC = [[NSClassFromString(className) alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"SEVEN TREES";
}

- (void)fm_refreshData {
    [_mainView.viewModel.refreshSubject sendNext:nil];
}

#pragma mark - Lazyload


@end
