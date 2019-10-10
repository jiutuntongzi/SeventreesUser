//
//  FMPasswordInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPasswordInputView.h"

@interface FMPasswordInputView ()

@property (weak, nonatomic) IBOutlet UIButton *plaintextButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation FMPasswordInputView

- (void)becomeFirstResponder {
    [_passwordTextField becomeFirstResponder];
}

- (void)fm_setupSubviews {
    _passwordTextField.ctf_clearButtonMode(UITextFieldViewModeAlways).ctf_keyboardType(UIKeyboardTypeDefault)\
    .ctf_placeholderFontSize(15.f); // .ctf_placeholderTextColor(UIColor.lightGrayColor)
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [RACObserve(self.viewModel, password) subscribeNext:^(NSString *password) {
        @strongify(self);
        self->_passwordTextField.text = password;
    }];
    
    [RACObserve(self.viewModel, isShowPlaintext) subscribeNext:^(NSNumber *isShowPlaintext) {
        @strongify(self);
        self->_plaintextButton.hidden = !isShowPlaintext.boolValue;
    }];
    
    [[_plaintextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *plaintextButton) {
        @strongify(self);
        
        self.viewModel.isPlaintext = !self.viewModel.isPlaintext;
        
        [self.viewModel.plaintextTouchSubject sendNext:nil];
    }];
    
    [RACObserve(self.viewModel, isPlaintext) subscribeNext:^(NSNumber *isPlaintext) {
        @strongify(self);
        
        NSString *cleartextImgName;
        if (isPlaintext.boolValue == YES) {
            cleartextImgName = @"icon_cleartextPassword";
        } else {
            cleartextImgName = @"icon_cleartextPhone";
        }
        self->_plaintextButton.cb_setImageOfNamed(cleartextImgName);
        self->_passwordTextField.secureTextEntry = !isPlaintext.boolValue;
    }];
    
    
    self.viewModel.password = _passwordTextField.text;
    
    //    RAC(self.viewModel, password) = _passwordTextField.rac_textSignal;
    
    [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        self.viewModel.password = textField.text;
        [self.viewModel.textChangedSubject sendNext:textField.text];
    }];
}

- (FMPasswordInputViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMPasswordInputViewModel alloc] init];
        _viewModel.isPlaintext = YES;
        _viewModel.isShowPlaintext = YES;
    }
    return _viewModel;
}

@end
