//
//  FMInputController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMInputController.h"

#import "FMInputView.h"
#import "FMInputViewModel.h"

@interface FMInputController ()

@property (nonatomic, strong) FMInputView *mainView;

@end

@implementation FMInputController

#pragma mark - System Functions

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = (FMInputView *)FMInputView.cv_viewFromNibLoad();
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    __weak typeof(self) weakSelf = self;
    
    [_mainView.viewModel.nextPageSubject subscribeNext:^(id x) {
        FMInputController *nextVC = [[FMInputController alloc] init];
        nextVC.type = FMInputControllerTypeBindPhone;
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
}

- (void)fm_setupNavbar {
    if (_type == FMInputControllerTypeBindPhone) {
        self.navigationItem.title = @"绑定新手机号";
    } else {
        self.navigationItem.title = @"修改手机号";
    }
}

- (void)fm_refreshData {
    NSString *hintText = @"为了您的账号安全，请先验证您的旧手机号码";
    NSString *buttonTitle = @"下一步";
    if (_type == FMInputControllerTypeBindPhone) {
        hintText = @"请输入您的手机号码，修改成功后，您可使用新手机号码登录，原消费记录将保留到新手机账号中";
        buttonTitle = @"确认绑定";
    }
    _mainView.viewModel.hintText = hintText;
    _mainView.viewModel.buttonTitle = buttonTitle;
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
