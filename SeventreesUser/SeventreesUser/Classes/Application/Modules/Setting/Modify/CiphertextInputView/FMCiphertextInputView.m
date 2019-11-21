//
//  FMCiphertextInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCiphertextInputView.h"

@interface FMCiphertextInputView ()

@property (weak, nonatomic) IBOutlet UIButton *cleartextButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation FMCiphertextInputView

- (void)fm_setupSubviews {
   _passwordTextField.ctf_clearButtonMode(UITextFieldViewModeAlways).ctf_placeholderFontSize(15.f); 
}

- (void)fm_bindViewModel {
    @weakify(self)

    [RACObserve(self.viewModel, isShowPlaintext) subscribeNext:^(NSNumber *isShowPlaintext) {
        @strongify(self);
        self->_cleartextButton.hidden = !isShowPlaintext.boolValue;
    }];
    
    [[_cleartextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *cleartextButton) {
        @strongify(self);
        
        self.viewModel.isPlaintext = !self.viewModel.isPlaintext;
        
        [self.viewModel.plaintextTouchSubject sendNext:nil];
    }];
    
    [RACObserve(self.viewModel, isPlaintext) subscribeNext:^(NSNumber *isPlaintext) {
        @strongify(self);
        
        NSString *cleartextImgName;
        if (isPlaintext.boolValue == YES) {
            cleartextImgName = @"icon_cleartext";
        } else {
            cleartextImgName = @"icon_cleartext";
        }
        self->_cleartextButton.cb_imageOfNamed(cleartextImgName);
        self->_passwordTextField.secureTextEntry = !isPlaintext.boolValue;
    }];
    
    
    RAC(self.viewModel, passwordNumber) = _passwordTextField.rac_textSignal;
    
    [[_passwordTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self)
        [self.viewModel.textChangedSubject sendNext:textField.text];
    }];
    
}

- (void)fm_becomeFirstResponder {
    [_passwordTextField becomeFirstResponder];
}

- (UITextField * (^)(NSString *))textFieldByPlaceholder {
    return ^(NSString *placeholder) {
        UITextField *textField = UITextField.ctf_textField();
        textField.ctf_textColorRGBA(122, 133, 123, 1.0f).ctf_placeholder(placeholder).ctf_fontSize(16.f)\
        .ctf_placeholderTextColorRGBA(111, 222, 333, 1.0f).ctf_placeholderFontSize(14.f)\
        .ctf_borderStyle(UITextBorderStyleRoundedRect)\
        .cv_backColorByHexString(@"#ffaabb");
        return textField;
    };
}

- (FMCiphertextInputViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMCiphertextInputViewModel alloc] init];
        _viewModel.isPlaintext = YES;
    }
    return _viewModel;
}

@end
