//
//  FMSetPasswordView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSetPasswordView.h"
#import "FMPhoneNumberInputView.h"
#import "FMPasswordInputView.h"

#import "DialogBoxView.h"

@interface FMSetPasswordView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentHeightCons;

@property (weak, nonatomic) IBOutlet UIView *inputContentView1;
@property (nonatomic, strong) FMPhoneNumberInputView *phoneNumberInputView;

@property (weak, nonatomic) IBOutlet UIView *inputContentView2;
@property (nonatomic, strong) FMPasswordInputView *passwordInputView;

@property (nonatomic, weak) IBOutlet UIButton *setButton;

@end

@implementation FMSetPasswordView

#pragma mark - Public Functions


#pragma mark - System Functions

//- (instancetype)initWithViewModel:(id<FMViewModelProtocol>)viewModel {
//    _viewModel = (FMLoginViewModel *)viewModel;
//
//    return [super initWithViewModel:viewModel];
//}

- (void)updateConstraints {
    _scrollViewContentHeightCons.constant = self.frame.size.height;
    
    _phoneNumberInputView.cv_frame(_inputContentView1.bounds);
    
    _passwordInputView.cv_frame(_inputContentView2.bounds);
    
    [super updateConstraints];
}


#pragma mark - Private Functions

- (void)fm_setupSubviews {
    
    FMPhoneNumberInputView *phoneNumberInputView = FMPhoneNumberInputView.cv_viewFromNibLoad();
    phoneNumberInputView.viewModel.isShowPlaintext = YES;
    _phoneNumberInputView = phoneNumberInputView;
    _inputContentView1.cv_addSubview(phoneNumberInputView);
    
    FMPasswordInputView *passwordInputView = FMPasswordInputView.cv_viewFromNibLoad();
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
     [[_setButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
         @strongify(self);
         
         // test
         [DialogBoxView showByTitle:@"发现新版本" message:@" 1. 日常系统优化\n\n 2. 新增会员心痛，提升用户优惠服务\n\n 3. 年中大庆开始啦！参与活动暑假嗨到底" affirmButtonTitle:@"确定" forStyle:DialogBoxViewStyleInput affirmHandler:^(NSString *inputText) {
             DLog(@"点了确定OK inputText == %@", inputText);
         }];
         
//         self.cv_endEditing();
//         [self.viewModel.requestDataCommand execute:@(666)]; // 执行设置请求命令
     }];
     
     
// RAC(self.viewModel.loginModel, account) = _accountTextField.rac_textSignal;
// RAC(self.viewModel.loginModel, password) = _passwordTextField.rac_textSignal;
// RAC(_loginButton, enabled) = self.viewModel.loginEnableSignal;
//
// @weakify(self);
//
// [[_accountTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
// @strongify(self);
// if (textField.text.length == 11) self.passwordTextField.ctf_becomeFirstResponder();
// }];
//
// [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
// @strongify(self);
//
// self.cv_endEditing();
// [self.viewModel.requestDataCommand execute:@(666)]; // 执行登录请求命令
// }];
//
// [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(id x) {
// @strongify(self);
// [self.viewModel.requestDataCommand execute:@(666)]; // 执行登录请求命令
// }];
//
// [_viewModel.refreshUISubject subscribeNext:^(id x) {
// @strongify(self);
//
// DLog(@"请求登录完成，提示登录成功状态：x == %@", x);
// [self refreshUI];
// }];
 }


- (void)refreshUI {
    DLog(@"提示登录成功状态");
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"销毁了");
}

@end