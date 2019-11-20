//
//  FMOrderContactUsView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderContactUsView.h"

@interface FMOrderContactUsView ()

@property (nonatomic, weak) IBOutlet UIButton *guideButton;

@property (nonatomic, weak) IBOutlet UIButton *serverButton;

@end

@implementation FMOrderContactUsView

- (void)fm_setupSubviews {
    void (^setStyleBlock)(UIView *) = ^(UIView *view) {
        view.layer.cornerRadius = 5.f;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = UIColor.cc_colorByHexString(@"#E5E5E5").CGColor;
    };
    setStyleBlock(_guideButton);
    setStyleBlock(_serverButton);
}

- (void)fm_bindViewModel {
    [[_guideButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        DLog(@"点了联系导购");
    }];
    [[_serverButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        DLog(@"点了联系客服");
    }];
}

@end
