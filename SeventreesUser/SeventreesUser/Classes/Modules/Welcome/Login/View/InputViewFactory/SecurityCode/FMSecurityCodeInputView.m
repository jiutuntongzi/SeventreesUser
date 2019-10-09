//
//  FMSecurityCodeInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSecurityCodeInputView.h"

@interface FMSecurityCodeInputView ()

@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

@end

@implementation FMSecurityCodeInputView

- (void)becomeFirstResponder {
    [_verifyCodeTextField becomeFirstResponder];
}

- (void)fm_setupSubviews {
    _verifyCodeTextField.ctf_clearButtonMode(UITextFieldViewModeAlways).ctf_keyboardType(UIKeyboardTypeNumberPad)\
    .ctf_placeholderFontSize(15.f); // .ctf_placeholderTextColor(UIColor.lightGrayColor)
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    self.viewModel.verifyCode = _verifyCodeTextField.text;
    
//    RAC(self.viewModel, verifyCode) = _verifyCodeTextField.rac_textSignal;
    
    [[_verifyCodeTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        self.viewModel.verifyCode = textField.text;
        [self.viewModel.textChangedSubject sendNext:textField.text];
    }];
    
    [[_sendCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *plaintextButton) {
        @strongify(self);
        [self.viewModel.sendActionSubject sendNext:nil];
    }];
}

- (FMSecurityCodeInputViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSecurityCodeInputViewModel alloc] init];
    }
    return _viewModel;
}

@end
