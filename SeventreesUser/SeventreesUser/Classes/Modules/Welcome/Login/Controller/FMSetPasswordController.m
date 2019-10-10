//
//  FMSetPasswordController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSetPasswordController.h"
#import "FMSetPasswordView.h"
#import "FMRegisterModel.h"

@interface FMSetPasswordController ()

@property (nonatomic, strong) FMSetPasswordView *mainView;

@end

@implementation FMSetPasswordController

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
}

- (void)fm_refreshData {
    _mainView.viewModel.registerModel = _registerModel;
}

#pragma mark - Lazyload

- (FMSetPasswordView *)mainView {
    if (!_mainView) {
        _mainView = FMSetPasswordView.cv_viewFromNibLoad();
    }
    return _mainView;
}

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
