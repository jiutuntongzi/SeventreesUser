//
//  FMScoreHeaderView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreHeaderView.h"

@interface FMScoreHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *integralNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *explainButton;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation FMScoreHeaderView

- (void)fm_setupSubviews {
    _explainButton.layer.cornerRadius = 9.f;
    _explainButton.layer.borderColor = UIColor.whiteColor.CGColor;
    _explainButton.layer.borderWidth = 1.f;
    _explainButton.clipsToBounds = YES;
    
    _signInButton.layer.cornerRadius = 15.f;
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, viewModel.scoreEntity) subscribeNext:^(FMScoreModel *scoreEntity) {
        @strongify(self)
        self->_integralNumLabel.text = scoreEntity.integralNum ? scoreEntity.integralNum.stringValue : @"--";
        
        if (scoreEntity.signType.integerValue == 1) {
            self->_signInButton.cb_title(@"  已签到  ");
            self->_signInButton.enabled = NO;
        } else {
            self->_signInButton.cb_title(@"    立即签到领积分    ");
            self->_signInButton.enabled = YES;
        }
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [[_signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.requestSignInCommand execute:nil];
    }];
    
    [[_explainButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.nextPageSubject sendNext:@""];
//        [self.viewModel.requestWebExplainCommand execute:nil];
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
    }];
    
    [[self.viewModel.requestSignInCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:nil];
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
    }];
}

- (FMScoreHeaderViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMScoreHeaderViewModel alloc] init];
    }
    return _viewModel;
}

@end
