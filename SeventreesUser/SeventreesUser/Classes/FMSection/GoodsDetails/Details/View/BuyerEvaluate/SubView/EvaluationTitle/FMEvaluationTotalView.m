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

@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

@end

@implementation FMEvaluationTotalView

- (void)setEvaluateTotal:(NSNumber *)evaluateTotal {
    _evaluateTotal = evaluateTotal;
    
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [[_arrowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        // test
        UIViewController *nextVC = [[NSClassFromString(@"FMEvaluationController") alloc] init];
        self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
        
//        [self.viewModel.actionSubject sendNext:self.viewModel.model];
    }];
}

@end
