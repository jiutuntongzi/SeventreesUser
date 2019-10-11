//
//  FMRegisterController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRegisterController.h"
#import "FMRegisterView.h"

#import "FMSetPasswordController.h"

@interface FMRegisterController ()

@property (nonatomic, strong) FMRegisterView *mainView;

@end

@implementation FMRegisterController

#pragma mark - System Functions

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
    @weakify(self)
    [self.mainView.viewModel.nextActionSubject subscribeNext:^(FMRegisterModel *registerModel) {
        @strongify(self)
        FMSetPasswordController *nextVC = [[FMSetPasswordController alloc] init];
        nextVC.registerModel = registerModel;
        [self presentViewController:nextVC animated:YES completion:nil];
    }];
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"注册账号";
}

- (void)fm_refreshData {
}

- (void)dealloc {
    DLog(@"VC销毁了");
}


@end
