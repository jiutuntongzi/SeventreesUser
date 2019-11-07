//
//  FMSetPasswordController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSetPasswordController.h"
#import "FMSetPasswordView.h"

#import "FMLoginController.h"

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
    @weakify(self)
    [self.mainView.viewModel.registerSuccessSubject subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self);
        [SVProgressHUD showSuccessWithStatus:resultModel.statusMsg];
        FMLoginController *nextVC = [[FMLoginController alloc] init];
        [self presentViewController:nextVC animated:YES completion:nil];
    }];
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
