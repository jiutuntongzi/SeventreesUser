//
//  FMPhoneNumberInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPhoneNumberInputView.h"

@interface FMPhoneNumberInputView ()

@property (weak, nonatomic) IBOutlet UIButton *plaintextButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation FMPhoneNumberInputView

- (void)becomeFirstResponder {
    [_phoneTextField becomeFirstResponder];
}

- (void)fm_setupSubviews {
    _phoneTextField.ctf_clearButtonMode(UITextFieldViewModeAlways).ctf_keyboardType(UIKeyboardTypeNumberPad)\
    .ctf_placeholderFontSize(15.f); // .ctf_placeholderTextColor(UIColor.lightGrayColor)
}

- (void)fm_bindViewModel {
    @weakify(self);

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
        self->_phoneTextField.secureTextEntry = !isPlaintext.boolValue;
    }];
    
    
    self.viewModel.phoneNumber = _phoneTextField.text;
    
//    RAC(self.viewModel, phoneNumber) = _phoneTextField.rac_textSignal;
    
    [[_phoneTextField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        self.viewModel.phoneNumber = textField.text;
        [self.viewModel.textChangedSubject sendNext:textField.text];
    }];
}

/*
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
*/

- (FMPhoneNumberInputViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMPhoneNumberInputViewModel alloc] init];
        _viewModel.isPlaintext = YES;
    }
    return _viewModel;
}

@end
