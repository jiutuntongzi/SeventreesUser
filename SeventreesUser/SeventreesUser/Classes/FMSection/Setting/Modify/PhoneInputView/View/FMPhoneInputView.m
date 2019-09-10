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

//- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
//    _viewModel = (FMPhoneInputViewModel *)_viewModel;
//
//    return [super initWithViewModel:viewModel];
//}

- (void)setViewModel:(FMPhoneInputViewModel *)viewModel {
    _viewModel = viewModel;
    
    _textField.ctf_placeholder(viewModel.placeholderText);
    
    [self fm_bindViewModel];
}

- (void)fm_setupSubviews {
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);

    [[_textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        @strongify(self);
        [self->_viewModel.textChangeSubject sendNext:textField.text];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

//- (FMPhoneInputViewModel *)viewModel {
//    if (!_viewModel) {
//        _viewModel = [[FMPhoneInputViewModel alloc] init];
//    }
//    return _viewModel;
//}


@end
