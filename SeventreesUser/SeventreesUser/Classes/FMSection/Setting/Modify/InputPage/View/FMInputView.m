//
//  FMInputView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMInputView.h"

#import "FMPhoneInputView.h"
#import "FMVerifyInputView.h"

@interface FMInputView ()

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UIView *inputContainerView1;
@property (nonatomic, strong) FMPhoneInputView *phoneInputView;

@property (weak, nonatomic) IBOutlet UIView *inputContainerView2;
@property (nonatomic, strong) FMVerifyInputView *verifyInputView;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation FMInputView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

//- (void)setViewModel:(FMInputViewModel *)viewModel {
//    _viewModel = viewModel;
//
//
//}
//
//- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
//    _viewModel = (FMInputViewModel *)_viewModel;
//
//    return [super initWithViewModel:viewModel];
//}

- (void)fm_setupSubviews {
    _phoneInputView = (FMPhoneInputView *)FMPhoneInputView.cv_viewFromNibLoad();
    [_inputContainerView1 addSubview:_phoneInputView];
    
    _verifyInputView = (FMVerifyInputView *)FMVerifyInputView.cv_viewFromNibLoad();
    [_inputContainerView2 addSubview:_verifyInputView];
    
    self.cv_addTouchEventCallback(^(UIView *view) { view.cv_endEditing(); });
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [RACObserve(self.viewModel, hintText) subscribeNext:^(NSString *hintText) {
        @strongify(self);
        self.hintLabel.text = [hintText copy];
    }];
    
    [RACObserve(self.viewModel, buttonTitle) subscribeNext:^(NSString *title) {
        @strongify(self);
        self.nextButton.cb_title(title);
    }];
    
    
    [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.requestDataCommand execute:@(0)]; // 执行网络请求
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NSDictionary *result) {
        @strongify(self);
        [SVProgressHUD showInfoWithStatus:@"修改成功"]; // result[@"msg"]
        
        [self.viewModel.nextPageSubject sendNext:nil];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [_phoneInputView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_inputContainerView1);
    }];
    [_verifyInputView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_inputContainerView2);
    }];
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMInputViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMInputViewModel alloc] init];
    }
    return _viewModel;
}

@end
