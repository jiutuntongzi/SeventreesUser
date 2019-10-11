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

@property (nonatomic, weak) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *loginTypeButton;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (nonatomic, weak) IBOutlet UIButton *userAgreementButton;

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
    _loginTypeButton.cb_title(loginStyleText);
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
    passwordInputView.viewModel.isPlaintext = NO;
    _passwordInputView = passwordInputView;
    _inputContentView2.cv_addSubview(passwordInputView);
    
    @weakify(self)
    self.cv_addTouchEventCallback(^(UIView *view) {
        self_weak_.cv_endEditing();
    });

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);

//    RAC(_loginButton, enabled) = self.viewModel.loginEnableSignal;
    
    [[_loginTypeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        self.style = !self->_style; // set
        
        if (self->_style == FMLoginViewStylePassword) {
            [self->_passwordInputView becomeFirstResponder];
        } else if (self->_style == FMLoginViewStylePhoneNumber)  {
            [self->_securityCodeInputView becomeFirstResponder];
        }
    }];
    
    [[_userAgreementButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self.viewModel.agreementActionSubject sendNext:nil];
    }];
    
    [[self.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.registerActionSubject sendNext:nil];
    }];
    
    [_phoneNumberInputView.viewModel.textChangedSubject subscribeNext:^(NSString *phoneNumber) {
        @strongify(self);
        self.viewModel.loginModel.phoneNumber = phoneNumber;
        
        self.viewModel.loginModel.verifyCode = nil;
        self->_securityCodeInputView.viewModel.verifyCode = nil;
        if (phoneNumber.length == 11) {
            if (self->_style == FMLoginViewStylePassword) {
                [self->_passwordInputView becomeFirstResponder];
            } else if (self->_style == FMLoginViewStylePhoneNumber)  {
                [self->_securityCodeInputView becomeFirstResponder];
            }
        }
    }];
    
    [_passwordInputView.viewModel.textChangedSubject subscribeNext:^(NSString *password) {
        @strongify(self);
        self.viewModel.loginModel.password = password;
        if (password.length == 8) self.cv_endEditing();
    }];
    
    [_securityCodeInputView.viewModel.textChangedSubject subscribeNext:^(NSString *verifyCode) {
        @strongify(self);
        self.viewModel.loginModel.verifyCode = verifyCode;
        if (verifyCode.length == 4) self.cv_endEditing();
    }];
    
    [_securityCodeInputView.viewModel.sendActionSubject subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.loginModel.phoneNumber.length != 11) {
            [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码"];
            [self->_phoneNumberInputView becomeFirstResponder];
            return;
        }
        [self->_securityCodeInputView startCountdown];
        [self.viewModel.requestVerifyCodeCommand execute:nil]; // 执行命令:请求获取验证码
    }];
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        self.cv_endEditing();
        if (self.viewModel.loginModel.phoneNumber.length != 11) {
            [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码"];
            [self->_phoneNumberInputView becomeFirstResponder];
            return;
        }
        if (self->_style == FMLoginViewStylePhoneNumber) {
            self.viewModel.loginModel.password = nil;
            self->_passwordInputView.viewModel.password = nil;
            
            if (self.viewModel.loginModel.verifyCode.length != 4) {
                [SVProgressHUD showInfoWithStatus:@"请输入4位验证码"];
                [self->_securityCodeInputView becomeFirstResponder];
                return;
            }
        } else if (self->_style == FMLoginViewStylePassword) {
            self.viewModel.loginModel.verifyCode = nil;
            self->_securityCodeInputView.viewModel.verifyCode = nil;
            
            if (self.viewModel.loginModel.password.length < 6) {
                [SVProgressHUD showInfoWithStatus:@"请输入6~8位密码"];
                [self->_passwordInputView becomeFirstResponder];
                return;
            }
        }
        [self.viewModel.requestDataCommand execute:nil]; // 执行登录请求命令
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
        if ([resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showSuccessWithStatus:resultModel.statusMsg];
        } else {
            [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
        }
    }];
    
    [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showWithStatus:@"登录中.."];
            //            DLog(@"（登录命令执行中..）");
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
            //            DLog(@"（登录命令未开始 / 登录命令执行完成");
        }
    }];
    
//    [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(id x) {
//        @strongify(self);
//        [self.viewModel.requestDataCommand execute:@(666)]; // 执行登录请求命令
//    }];
//
//    [_viewModel.refreshUISubject subscribeNext:^(id x) {
//        @strongify(self);
//
//        DLog(@"请求登录完成，提示登录成功状态：x == %@", x);
//        [self refreshUI];
//    }];
}

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

@end
