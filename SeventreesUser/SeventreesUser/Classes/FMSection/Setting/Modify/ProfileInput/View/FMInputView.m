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
#import "FMCiphertextInputView.h"

#import "DialogBoxView.h"

@interface FMInputView ()

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UIView *inputContainerView1;
@property (nonatomic, strong) UIView *numberInputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputTopCons;


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
    _inputHeightCons.constant = 40.f;
    _inputTopCons.constant = 30.f;
    
    _numberInputView = FMPhoneInputView.cv_viewFromNibLoad();
    [_inputContainerView1 addSubview:_numberInputView];
    
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
    
    [RACObserve(self.viewModel, type) subscribeNext:^(NSNumber *type) {
        @strongify(self);
        [self setupUIForPageType:type.unsignedIntegerValue];
    }];
    
    [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.viewModel.type == FMInputViewTypeBindStore) {
            NSString *message = @"因门店间会员信息不共享，修改门店将导致您锁拥有的积分、优惠券、会员等级全部重置，请确认后再操作哦 ！";
            [DialogBoxView showByTitle:@"换绑门店须知" message:message affirmButtonTitle:@"我知道了" forStyle:DialogBoxViewStyleHint affirmHandler:^(NSString * _Nullable text) {
                [self.viewModel.requestDataCommand execute:@(0)]; // 执行网络请求
            }];
        } else {
            [self.viewModel.requestDataCommand execute:@(0)]; // 执行网络请求
        }
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NSDictionary *result) {
        @strongify(self);
        [SVProgressHUD showSuccessWithStatus:@"修改成功"]; // result[@"msg"]
        [self.viewModel.nextPageSubject sendNext:nil];
    }];
}

- (void)setupUIForPageType:(FMInputViewType)type {
    
    NSString *hintText = @"为了您的账号安全，请先验证您的旧手机号码";
    NSString *buttonTitle = @"下一步";
    if (type == FMInputViewTypeBindPhone) {
        hintText = @"请输入您的手机号码，修改成功后，您可使用新手机号码登录，原消费记录将保留到新手机账号中";
        buttonTitle = @"确认绑定";
        
    } else if (type == FMInputViewTypeModifyPassword) {
        hintText = [NSString stringWithFormat:@"我们会向您的手机号码：%s发送一条验证短信，验证通过后，可修改登录密码", "132****1234"];
        buttonTitle = @"确认修改";
        
        [_verifyInputView removeFromSuperview];
        [_numberInputView removeFromSuperview];
        
        [_inputContainerView1 addSubview:_verifyInputView];
        
        _numberInputView = nil;
        _numberInputView = (FMCiphertextInputView *)FMCiphertextInputView.cv_viewFromNibLoad();
        [_inputContainerView2 addSubview:_numberInputView];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
    } else if (type == FMInputViewTypeBindStore) {
        hintText = @"换绑门店请先验证您的手机号码";
        buttonTitle = @"提交验证";
        _inputHeightCons.constant = 0.f;
        _inputTopCons.constant = 0.f;
        
    } else {
        hintText = @"为了您的账号安全，请先验证您的旧手机号码";
        buttonTitle = @"下一步";
    }
    self.viewModel.hintText = hintText;
    self.viewModel.buttonTitle = buttonTitle;
}

#pragma mark - System Functions

- (void)updateConstraints {

    if (self.viewModel.type == FMInputViewTypeModifyPassword) {
        [_verifyInputView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_inputContainerView1);
        }];
        [_numberInputView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_inputContainerView2);
        }];
        
    } else {
        [_numberInputView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_inputContainerView1);
        }];
        [_verifyInputView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self->_inputContainerView2);
        }];
    }
    
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
