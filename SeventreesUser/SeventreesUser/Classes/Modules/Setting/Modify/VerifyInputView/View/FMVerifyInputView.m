//
//  FMVerifyInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMVerifyInputView.h"

const CGFloat FMVerifyInputViewHeight = 44.f;

@interface FMVerifyInputView ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;

@end

@implementation FMVerifyInputView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    _textField.ctf_clearButtonMode(UITextFieldViewModeAlways).ctf_placeholderFontSize(15.f);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    RAC(self.viewModel, verifyCodeText) = _textField.rac_textSignal;
    
    [[_textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        [self->_viewModel.textChangeSubject sendNext:textField.text];
    }];
    
    [[_verifyCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.verifyActionSubject sendNext:nil];
    }];
}

- (void)fm_becomeFirstResponder {
    [_textField becomeFirstResponder];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMVerifyInputViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMVerifyInputViewModel alloc] init];
    }
    return _viewModel;
}

@end
