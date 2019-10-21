//
//  FMEvaluationTotalView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/4.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMEvaluationTotalView.h"

const CGFloat FMEvaluationTotalViewHeight = 44.f;

@interface FMEvaluationTotalView ()

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

@end

@implementation FMEvaluationTotalView

- (void)setEvaluateTotal:(NSInteger )evaluateTotal {
    _evaluateTotal = evaluateTotal;
    
    _totalLabel.text = [NSString stringWithFormat:@"用户评价(%ld)", evaluateTotal];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [[_arrowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        if (self->_showAllCallback) self->_showAllCallback();
    }];
}

@end
