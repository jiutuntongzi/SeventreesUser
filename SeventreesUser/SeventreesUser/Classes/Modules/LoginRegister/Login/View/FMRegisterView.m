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

@property (nonatomic, weak) IBOutlet UIButton *dismissButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeightCons;

@property (weak, nonatomic) IBOutlet UIView *inputContentView1;
@property (nonatomic, strong) FMPhoneNumberInputView *phoneNumberInputView;

@property (weak, nonatomic) IBOutlet UIView *inputContentView2;
@property (nonatomic, strong) FMSecurityCodeInputView *securityCodeInputView;

@property (nonatomic, weak) IBOutlet UIButton *isAgreeButton;

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
    [_phoneNumberInputView becomeFirstResponder];
    _inputContentView1.cv_addSubview(phoneNumberInputView);
    
    FMSecurityCodeInputView *securityCodeInputView = FMSecurityCodeInputView.cv_viewFromNibLoad();
    _securityCodeInputView = securityCodeInputView;
    _inputContentView2.cv_addSubview(securityCodeInputView);
    
    __weak typeof(self) weakSelf = self;
    self.cv_addTouchEventCallback(^(UIView *view) {
        weakSelf.cv_endEditing();
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
     
     [_phoneNumberInputView.viewModel.textChangedSubject subscribeNext:^(NSString *phoneNumber) {
         @strongify(self);
         self.viewModel.registerModel.phoneNumber = phoneNumber;
         
         self.viewModel.registerModel.verifyCode = nil;
         self->_securityCodeInputView.viewModel.verifyCode = nil;
         if (phoneNumber.length == 11) [self->_securityCodeInputView becomeFirstResponder];
     }];
     
     [_securityCodeInputView.viewModel.textChangedSubject subscribeNext:^(NSString *verifyCode) {
         @strongify(self);
         self.viewModel.registerModel.verifyCode = verifyCode;
         if (verifyCode.length == 4) self.cv_endEditing();
     }];
     
     
     [[_isAgreeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *isAgreeButton) {
         @strongify(self);
         self.viewModel.registerModel.isAgree = ! self.viewModel.registerModel.isAgree;
     }];
     
     [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         @strongify(self);
         if (self.viewModel.registerModel.phoneNumber.length != 11) {
             [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码"];
             return;
         }
         if (self.viewModel.registerModel.verifyCode.length != 4) {
             [SVProgressHUD showInfoWithStatus:@"请输入4位验证码"];
             return;
         }
         if (self.viewModel.registerModel.isAgree == NO) {
             [SVProgressHUD showInfoWithStatus:@"请阅读并勾选用户注册协议"];
             return;
         }
         self.cv_endEditing();
         
         [self.viewModel.nextActionSubject sendNext:self.viewModel.registerModel];
     }];
     
     [_securityCodeInputView.viewModel.sendActionSubject subscribeNext:^(id x) {
         @strongify(self);
         if (self.viewModel.registerModel.phoneNumber.length != 11) {
             [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码"];
             return;
         }
         [self->_securityCodeInputView startCountdown];
         [self.viewModel.requestVerifyCodeCommand execute:nil]; // 执行命令:请求获取验证码
     }];
     
     [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
         if ([resultModel.statusCode isEqualToString:@"OK"]) {
             [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
             [SVProgressHUD showSuccessWithStatus:resultModel.statusMsg];
         } else {
             [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
         }
     }];
     
     [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
         if ([x isEqualToNumber:@(YES)]) {
             [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
             [SVProgressHUD showWithStatus:@" "];
//             DLog(@"（注册命令执行中..）");
         } else {
             [SVProgressHUD dismissWithDelay:1.f];
//             DLog(@"（注册命令未开始 / 注册命令执行完成");
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
