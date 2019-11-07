//
//  FMOrderExplainView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderExplainView.h"

@interface FMOrderExplainView ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *fuzhiButton;

@end

@implementation FMOrderExplainView

- (void)setOrderInfoText:(NSString *)orderInfoText {
    _orderInfoText = orderInfoText;
    
    _textView.text = orderInfoText;
}

- (void)fm_setupSubviews {
    
    
    void (^setStyleBlock)(UIView *) = ^(UIView *view) {
        view.layer.cornerRadius = 3.f;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    };
    setStyleBlock(_fuzhiButton);
}

- (void)fm_bindViewModel {
    [[_fuzhiButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [UIPasteboard generalPasteboard].string = self->_textView.text;
    }];
}

@end
