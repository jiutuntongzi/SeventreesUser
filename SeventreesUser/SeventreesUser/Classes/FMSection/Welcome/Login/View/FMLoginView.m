//
//  FMLoginView.m
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMLoginView.h"

#import "FMPhoneNumberInputView.h"
#import "FMSecurityCodeInputView.h"

#import "FMPasswordInputView.h"

@interface FMLoginView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeightCons;

@property (weak, nonatomic) IBOutlet UIView *inputContentView1;
@property (nonatomic, strong) FMPhoneNumberInputView *phoneNumberInputView;

@property (weak, nonatomic) IBOutlet UIView *inputContentView2;
@property (nonatomic, strong) FMSecurityCodeInputView *securityCodeInputView;
@property (nonatomic, strong) FMPasswordInputView *passwordInputView;

@property (weak, nonatomic) IBOutlet UIButton *loginStyleButton;
@property (nonatomic, weak) IBOutlet UIButton *setButton;

@end

@implementation FMLoginView

#pragma mark - Public Functions

- (void)setStyle:(FMLoginViewStyle)style {
    _style = style;
    
    _securityCodeInputView.hidden = _style == FMLoginViewStylePassword;
    _passwordInputView.hidden = _style == FMLoginViewStylePhoneNumber;
    
    NSString *loginStyleText = @"账号密码登录";
    if (_style == FMLoginViewStylePassword) {
        loginStyleText = @"手机验证码登录";
    } else if (_style == FMLoginViewStylePhoneNumber) {
        loginStyleText = @"账号密码登录";
    } else {
        _passwordInputView.hidden = YES;
        _securityCodeInputView.hidden = NO;
    }
    _loginStyleButton.cb_title(loginStyleText);
}

#pragma mark - System Functions

//- (instancetype)initWithViewModel:(id<FMViewModelProtocol>)viewModel {
//    _viewModel = (FMLoginViewModel *)viewModel;
//    
//    return [super initWithViewModel:viewModel];
//}

- (void)updateConstraints {
    _scrollViewContentHeightCons.constant = self.frame.size.height;
    
    _phoneNumberInputView.cv_frame(_inputContentView1.bounds);
    
    _securityCodeInputView.cv_frame(_inputContentView2.bounds);
    _passwordInputView.cv_frame(_inputContentView2.bounds);
    
    
//    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(20.f);
//        make.right.equalTo(-20.f);
//        make.height.equalTo(44.f);
//        make.centerY.equalTo(self);
//    }];
//
//    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(20.f);
//        make.right.equalTo(-20.f);
//        make.height.equalTo(44.f);
//        make.top.equalTo(self.accountTextField.bottom).offset(+25.f);
//    }];
//
//    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(130.f);
//        make.height.equalTo(44.f);
//        make.bottom.equalTo(self).offset(-50.f);
//        make.centerX.equalTo(self);
//    }];
    
    // 在这拿不到self的Frame，因为view初始化时没有传frame
    
//    CGFloat centerX = SCREEN_W * 0.5f, centerY = SCREEN_H * 0.5f;
//    _loginButton.cv_frameOf(0.0f, 0.0f, 200.0f, 44.0f);
//    _loginButton.center = CGPointMake(centerX, centerY + 280.0f);
//
//    CGRect frame = CGRectMake(0.0f, 0.0f, 250.0f, 44.0f);
//    _accountTextField.cv_frame(frame);
//    _passwordTextField.cv_frame(frame);
//    _accountTextField.center = CGPointMake(centerX, centerY - 50.f);
//    _passwordTextField.center = CGPointMake(centerX, centerY + 25.f);

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
    
    FMPasswordInputView *passwordInputView = FMPasswordInputView.cv_viewFromNibLoad();
    _passwordInputView = passwordInputView;
    _inputContentView2.cv_addSubview(passwordInputView);
    
    @weakify(self)
    self.cv_addTouchEventCallback(^(UIView *view) {
        self_weak_.cv_endEditing();
    });
    
//    _loginButton = UIButton.cb_buttonWithType(1);
    
//    _loginButton.cb_fontSize(15.f).cb_title(@"登录").cb_titleColor(UIColor.whiteColor).cv_backColorRGBA(247.f, 111.f, 111.f, 1.f).cv_layerCornerRadius(5.0f);
    
//    _accountTextField = self.textFieldByPlaceholder(@"手机号").ctf_keyboardType(UIKeyboardTypePhonePad).ctf_becomeFirstResponder();
//
//    _passwordTextField = self.textFieldByPlaceholder(@"密码").ctf_returnKeyType(UIReturnKeyDone);
    
//    self.cv_addSubviews(@[_accountTextField, _passwordTextField, _loginButton]);
    
//    [self addSubview:_loginButton];
//    [self addSubview:_accountTextField];
//    [self addSubview:_passwordTextField];
//    self.cv_addSubview(_loginButton).cv_addSubview(_accountTextField).cv_addSubview(_passwordTextField);

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

- (FMLoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMLoginViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
