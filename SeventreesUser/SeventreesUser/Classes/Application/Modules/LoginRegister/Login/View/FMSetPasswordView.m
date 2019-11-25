//
//  FMSetPasswordView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSetPasswordView.h"
#import "FMPasswordInputView.h"

#import "DialogBoxView.h"

@interface FMSetPasswordView ()

@property (nonatomic, weak) IBOutlet UIButton *dismissButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeightCons;

@property (weak, nonatomic) IBOutlet UIView *inputContentView1;
@property (nonatomic, strong) FMPasswordInputView *showPasswordInputView;

@property (weak, nonatomic) IBOutlet UIView *inputContentView2;
@property (nonatomic, strong) FMPasswordInputView *hidePasswordInputView;

@property (nonatomic, weak) IBOutlet UIButton *affirmButton;

@end

@implementation FMSetPasswordView

#pragma mark - System Functions

- (void)updateConstraints {
    _scrollViewContentHeightCons.constant = self.frame.size.height;
    
    _showPasswordInputView.cv_frame(_inputContentView1.bounds);
    _hidePasswordInputView.cv_frame(_inputContentView2.bounds);
    
    [super updateConstraints];
}

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    FMPasswordInputView *showPasswordInputView = FMPasswordInputView.cv_viewFromNibLoad();
    showPasswordInputView.viewModel.isPlaintext = YES;
    _showPasswordInputView = showPasswordInputView;
    _inputContentView1.cv_addSubview(showPasswordInputView);
    [_showPasswordInputView becomeFirstResponder];
    
    FMPasswordInputView *hidePasswordInputView = FMPasswordInputView.cv_viewFromNibLoad();
    hidePasswordInputView.viewModel.isPlaintext = NO;
    _hidePasswordInputView = hidePasswordInputView;
    _inputContentView2.cv_addSubview(hidePasswordInputView);
    
    @weakify(self)
    self.cv_addTouchEventCallback(^(UIView *view) {
        self_weak_.cv_endEditing();
    });

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

 - (void)fm_bindViewModel {
     @weakify(self);
     
     [[_dismissButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         @strongify(self);
         [self.viewController dismissViewControllerAnimated:YES completion:nil];
     }];
     
     [_showPasswordInputView.viewModel.textChangedSubject subscribeNext:^(NSString *password) {
         @strongify(self);
         self.viewModel.registerModel.password = password;
         if (password.length == 8) [self->_hidePasswordInputView becomeFirstResponder];
     }];
     
     [_hidePasswordInputView.viewModel.textChangedSubject subscribeNext:^(NSString *repeatPassword) {
         @strongify(self);
         self.viewModel.registerModel.repeatPassword = repeatPassword;
         if (repeatPassword.length == 8) self.cv_endEditing();
     }];
    
     [[_affirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         @strongify(self);
         if (self.viewModel.registerModel.password.length < 6) {
             [SVProgressHUD showInfoWithStatus:@"请输入6~8位密码"];
             return;
         }
         if (self.viewModel.registerModel.repeatPassword.length < 6) {
             [SVProgressHUD showInfoWithStatus:@"请再次输入6~8位密码"];
             return;
         }
         if (self.viewModel.registerModel.password != self.viewModel.registerModel.repeatPassword) {
             [SVProgressHUD showInfoWithStatus:@"密码不一致请重新输入"];
             self.viewModel.registerModel.repeatPassword = nil;
             self->_hidePasswordInputView.viewModel.password = nil;
             return;
         }
         self.cv_endEditing();
         [self.viewModel.requestDataCommand execute:nil]; // 执行注册请求命令
     }];
     
     [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
         if (resultModel.isSuccess) {
             [SVProgressHUD showSuccessWithStatus:resultModel.statusMsg];
         } else {
             [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
         }
     }];
}

#pragma mark - Lazyload

- (FMRegisterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMRegisterViewModel alloc] init];
    }
    return _viewModel;
}

@end
