//
//  FMSlashScopeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashScopeView.h"

@interface FMSlashScopeView ()

@property (weak, nonatomic) IBOutlet UILabel *curPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIProgressView *perchProgressView;

@property (weak, nonatomic) IBOutlet UIButton *inviteFriendsButton;

@end

@implementation FMSlashScopeView

- (void)fm_setupSubviews {
//    _leftButton.layer.cornerRadius = 5.f;
//    _leftButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
//    _leftButton.layer.borderWidth = 1.f;
    
    _inviteFriendsButton.layer.cornerRadius = 5.f;
}

- (void)fm_bindObserver {
    @weakify(self)
    
    [RACObserve(self, curPrice) subscribeNext:^(id x) {
        @strongify(self)
        self->_curPriceLabel.text = [NSString stringWithFormat:@"当前价:￥%.2f", self->_curPrice];
        self->_lastPriceLabel.text = [NSString stringWithFormat:@"当前价:￥%.2f", self->_lastPrice];
//        self->_progressView.progress =
//        self->_perchProgressView.progress =
    }];
    
    [RACObserve(self, lastPrice) subscribeNext:^(id x) {
        @strongify(self)
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [[_inviteFriendsButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        DLog(@"点了 邀请好友帮我砍价");
        if (self->_inviteFriendsCallback) self->_inviteFriendsCallback();
    }];
}

@end
