//
//  FMOrderPayView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderPayView.h"

@interface FMOrderPayView ()

@property (nonatomic, weak) IBOutlet UIButton *cancelButton;

@property (nonatomic, weak) IBOutlet UIButton *goPayButton;

@end

@implementation FMOrderPayView

- (void)fm_setupSubviews {
    void (^setStyleBlock)(UIView *, UIColor *) = ^(UIView *view, UIColor *color) {
        view.layer.cornerRadius = 15.f;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = color.CGColor;
        [view clipsToBounds];
    };
    setStyleBlock(_cancelButton, UIColor.cc_colorByHexString(@"#DCDCDC"));
    setStyleBlock(_goPayButton, UIColor.cc_colorByHexString(@"#F76F6F"));
}

- (void)fm_bindViewModel {
    [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
    }];
    [[_goPayButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
    }];
}

@end
