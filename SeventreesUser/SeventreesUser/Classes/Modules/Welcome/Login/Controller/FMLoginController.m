//
//  FMLoginController.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMLoginController.h"
#import "FMLoginView.h"

#import "FMRegisterController.h"

@interface FMLoginController ()

@property (nonatomic, strong) FMLoginView *loginView;

@end

@implementation FMLoginController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)updateViewConstraints {
    self.loginView.cv_frame(self.view.bounds);
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    self.loginView.style = FMLoginViewStylePhoneNumber; // FMLoginViewStylePassword
    [self.view addSubview:self.loginView];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [self.loginView.viewModel.registerActionSubject subscribeNext:^(id x) {
        @strongify(self)
        UIViewController *nextVC = [[FMRegisterController alloc] init];
        [self presentViewController:nextVC animated:YES completion:nil];
    }];
    
    [self.loginView.viewModel.loginSuccessSubject subscribeNext:^(id x) {
        DLog(@"请求登录成功数据：%@", x);
//        UINavigationController *navController = UINavigationController.cnc_initWithRootViewController(UIViewController.cvc_controller().cvc_title(@"个人"));
//        self_weak_.cvc_presentVCAnimatedCompletion(navController, YES, nil);
    }];
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"登录";

    /*
    @weakify(self)
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"关闭", 1, ^(UIBarButtonItem *leftItem) {
        DLog(@"点了leftItem == %@", leftItem);
        self_weak_.view.cv_endEditing();
        [self_weak_ dismissViewControllerAnimated:YES completion:nil];
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
     */
}

- (void)fm_refreshData {
    DLog(@"");
}

#pragma mark - Lazyload

- (FMLoginView *)loginView{
    if (!_loginView) {
        _loginView = FMLoginView.cv_viewFromNibLoad();
    }
    return _loginView;
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
