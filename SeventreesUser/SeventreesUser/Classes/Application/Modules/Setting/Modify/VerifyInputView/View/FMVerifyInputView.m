//
//  FMVerifyInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMVerifyInputView.h"
#import "UIButton+Countdown.h"

const CGFloat FMVerifyInputViewHeight = 44.f;

@interface FMVerifyInputView ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *verifyCodeButton;

@end

@implementation FMVerifyInputView

@synthesize viewModel = _viewModel;

#pragma mark - Public Functions

- (void)startCountdownLimit:(NSInteger)limit {
    [_verifyCodeButton startWithLimit:limit title:@"等待%@秒"];
}

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
        @strongify(self)
        [self->_viewModel.textChangeSubject sendNext:textField.text];
    }];
    
    [[_verifyCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.verifyActionSubject sendNext:nil];
        
        if (!self.viewModel.bodyPhoneNumber) {
            [self.viewModel.showHintSubject sendNext:@"数据错误：验证码参数nil了"];
            return;
        }
        [self.viewModel.requestVerifyCodeCommand execute:nil];
    }];
    
    [UIView showStatusInfoBySubject:self.viewModel.showHintSubject];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        [self startCountdownLimit:30];
    }];
    
    [UIView showRequestHUDStatus:nil command:self.viewModel.requestVerifyCodeCommand];
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
