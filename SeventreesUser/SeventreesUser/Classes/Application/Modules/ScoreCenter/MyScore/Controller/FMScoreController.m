//
//  FMScoreController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreController.h"

#import "FMScoreView.h"
#import "FMScoreViewModel.h"
#import "WebViewController.h"

@interface FMScoreController ()

@property (nonatomic, strong) FMScoreView *mainView;

@end

@implementation FMScoreController

#pragma mark - System Functions

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMScoreView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    [_mainView.viewModel.nextPageSubject subscribeNext:^(NSString *webExplainURL) {
        [WebViewController showByPageType:WebViewControllerPageTypeScoreExplain];
//        [WebViewController showByURLString:webExplainURL];
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"我的积分";
}

- (void)fm_refreshData {
    [_mainView.viewModel.refreshUISubject sendNext:nil];
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
