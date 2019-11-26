//
//  FMPayView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPayView.h"

@interface FMPayView ()

@property (weak, nonatomic) IBOutlet UIImageView *commitStatusImgView;
@property (weak, nonatomic) IBOutlet UILabel *commitStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *paymentMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *alipayTypeButton;
@property (weak, nonatomic) IBOutlet UIImageView *alipayImgView;

@property (weak, nonatomic) IBOutlet UIButton *wechatPayTypeButton;
@property (weak, nonatomic) IBOutlet UIImageView *wechatPayImgView;

@property (weak, nonatomic) IBOutlet UIButton *affirmButton;

@end

@implementation FMPayView

#pragma mark - System Functions

- (void)updateConstraints {
 
    [super updateConstraints];
}


#pragma mark - Private Functions

- (void)fm_setupSubviews {

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindObserver {
    @weakify(self)
    
    [RACObserve(self.viewModel, paymentType) subscribeNext:^(id x) {
        @strongify(self)
        
        // code..
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [self.viewModel.refreshUISubject subscribeNext:^(FMPayModel *paymentEntity) {
        @strongify(self) if (!self) return;
        
    }];
    
    [UIView showStatusInfoBySubject:self.viewModel.showHintSubject];
    
    /// Actions
    
    [[_affirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
                   
        [self.viewModel.requestPaymentCommand execute:nil];
    }];
    
    [[_alipayTypeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
                   
        [self.viewModel.choicePaymentSubject sendNext:nil];
    }];
    
    [[_wechatPayTypeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self.viewModel.choicePaymentSubject sendNext:nil];
    }];
}

#pragma mark - Lazyload

- (FMPayViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMPayViewModel alloc] init];
    }
    return _viewModel;
}

@end
