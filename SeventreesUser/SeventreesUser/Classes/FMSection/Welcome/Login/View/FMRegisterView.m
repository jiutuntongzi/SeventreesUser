//
//  FMRegisterView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRegisterView.h"

#import "FMPhoneNumberInputView.h"
#import "FMSecurityCodeInputView.h"

@interface FMRegisterView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeightCons;

@property (weak, nonatomic) IBOutlet UIView *inputContentView1;
@property (nonatomic, strong) FMPhoneNumberInputView *phoneNumberInputView;

@property (weak, nonatomic) IBOutlet UIView *inputContentView2;
@property (nonatomic, strong) FMSecurityCodeInputView *securityCodeInputView;

@property (nonatomic, weak) IBOutlet UIButton *nextButton;

@end

@implementation FMRegisterView

#pragma mark - Public Functions


#pragma mark - System Functions

- (void)updateConstraints {
    _phoneNumberInputView.cv_frame(_inputContentView1.bounds);
    
    _securityCodeInputView.cv_frame(_inputContentView2.bounds);
    
    [super updateConstraints];
}


#pragma mark - Private Functions

- (void)fm_setupSubviews {
    
    FMPhoneNumberInputView *phoneNumberInputView = FMPhoneNumberInputView.cv_viewFromNibLoad();
    _phoneNumberInputView = phoneNumberInputView;
    _inputContentView1.cv_addSubview(phoneNumberInputView);
    
    FMSecurityCodeInputView *securityCodeInputView = FMSecurityCodeInputView.cv_viewFromNibLoad();
    _securityCodeInputView = securityCodeInputView;
    _inputContentView2.cv_addSubview(securityCodeInputView);
    
    @weakify(self)
    self.cv_addTouchEventCallback(^(UIView *view) {
        self_weak_.cv_endEditing();
    });
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

/*
 
 - (void)fm_bindViewModel {
 RAC(self.viewModel.loginModel, account) = _accountTextField.rac_textSignal;
 RAC(self.viewModel.loginModel, password) = _passwordTextField.rac_textSignal;
 RAC(_loginButton, enabled) = self.viewModel.loginEnableSignal;
 
 @weakify(self);
 
 [[_accountTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
 @strongify(self);
 if (textField.text.length == 11) self.passwordTextField.ctf_becomeFirstResponder();
 }];
 
 [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
 @strongify(self);
 
 self.cv_endEditing();
 [self.viewModel.requestDataCommand execute:@(666)]; // 执行登录请求命令
 }];
 
 [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(id x) {
 @strongify(self);
 [self.viewModel.requestDataCommand execute:@(666)]; // 执行登录请求命令
 }];
 
 [_viewModel.refreshUISubject subscribeNext:^(id x) {
 @strongify(self);
 
 DLog(@"请求登录完成，提示登录成功状态：x == %@", x);
 [self refreshUI];
 }];
 }
 
 */

- (void)refreshUI {
    DLog(@"提示登录成功状态");
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"销毁了");
}


@end
