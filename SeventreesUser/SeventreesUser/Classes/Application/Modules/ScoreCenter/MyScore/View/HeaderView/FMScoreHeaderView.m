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
        
        BOOL isSign = scoreEntity.signType.integerValue == 1;
        if (isSign) {
            self->_signInButton.cb_title(@"   已签到   ");
            self->_signInButton.enabled = !isSign;
            self->_signInButton.userInteractionEnabled = !isSign;
        } else {
            self->_signInButton.cb_title(@"    立即签到领积分    ");
            self->_signInButton.enabled = isSign;
            self->_signInButton.userInteractionEnabled = isSign;
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
        [self.viewModel.nextPageSubject sendNext:self.viewModel.webExplainURL];
//        [self.viewModel.requestWebExplainCommand execute:nil];
    }];
    
//    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
//        @strongify(self)    if (!self) return;
//    }];
    
    [UIView showRequestHUDStatus:nil command:self.viewModel.requestSignInCommand];
    
    [UIView showStatusInfoBySubject:self.viewModel.showHintSubject];
}

- (FMScoreHeaderViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMScoreHeaderViewModel alloc] init];
    }
    return _viewModel;
}

@end
