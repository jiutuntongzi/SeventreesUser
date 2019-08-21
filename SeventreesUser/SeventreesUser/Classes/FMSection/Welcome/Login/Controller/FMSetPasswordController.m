//
//  FMSetPasswordController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSetPasswordController.h"
#import "FMSetPasswordView.h"

@interface FMSetPasswordController ()

@property (nonatomic, strong) FMSetPasswordView *mainView;

@end

@implementation FMSetPasswordController

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
    [self.view addSubview:self.mainView];
}

- (void)fm_bindViewModel {
//    @weakify(self)
//    [self.mainView.viewModel.loginSuccessSubject subscribeNext:^(id x) {
//        DLog(@"请求登录成功数据：%@", x);
//        UINavigationController *navController = UINavigationController.cnc_initWithRootViewController(UIViewController.cvc_controller().cvc_title(@"个人"));
//        self_weak_.cvc_presentVCAnimatedCompletion(navController, YES, nil);
//    }];
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"设置密码";
    
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

- (FMSetPasswordView *)mainView {
    if (!_mainView) {
        _mainView = FMSetPasswordView.cv_viewFromNibLoad();
    }
    return _mainView;
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
