//
//  FMGoodsEvaluationView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsEvaluationView.h"

const CGFloat FMGoodsEvaluationViewHeight = 206.f;

@interface FMGoodsEvaluationView ()

@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

@end

@implementation FMGoodsEvaluationView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMGoodsEvaluationViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMGoodsEvaluationViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    self.cv_addTouchEventCallback(^(UIView *view) {
        view.cv_endEditing();
    });
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [[_arrowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel.actionSubject sendNext:self.viewModel.model];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMGoodsEvaluationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMGoodsEvaluationViewModel alloc] init];
    }
    return _viewModel;
}


@end
