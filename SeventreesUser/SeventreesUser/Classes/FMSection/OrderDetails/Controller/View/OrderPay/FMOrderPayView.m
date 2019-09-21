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
    void (^setStyleBlock)(UIView *) = ^(UIView *view) {
        view.layer.cornerRadius = 15.f;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    };
    setStyleBlock(_cancelButton);
    setStyleBlock(_goPayButton);
}

- (void)fm_bindViewModel {
    [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
    }];
    [[_goPayButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
    }];
}

@end
