//
//  FMRegisterController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRegisterController.h"
#import "FMRegisterView.h"

@interface FMRegisterController ()

@property (nonatomic, strong) FMRegisterView *mainView;

@end

@implementation FMRegisterController

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
    self.mainView = FMRegisterView.cv_viewFromNibLoad();
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
    self.navigationItem.title = @"注册账号";
    
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

- (void)dealloc {
    DLog(@"销毁了");
}


@end
