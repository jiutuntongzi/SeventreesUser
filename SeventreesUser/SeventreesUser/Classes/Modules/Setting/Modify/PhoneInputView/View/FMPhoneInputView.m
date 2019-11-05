//
//  FMPhoneInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPhoneInputView.h"

const CGFloat FMPhoneInputViewHeight = 44.f;

@interface FMPhoneInputView ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation FMPhoneInputView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    _textField.ctf_clearButtonMode(UITextFieldViewModeAlways).ctf_placeholderFontSize(15.f);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self.viewModel, placeholderText) subscribeNext:^(NSString *placeholderText) {
        @strongify(self)
        self->_textField.text = placeholderText;
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [[_textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self)
        [self.viewModel.textChangeSubject sendNext:textField.text];
    }];
}

- (void)fm_becomeFirstResponder {
    [_textField becomeFirstResponder];
}

#pragma mark - Lazyload

- (FMPhoneInputViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMPhoneInputViewModel alloc] init];
    }
    return _viewModel;
}

@end
