//
//  FMBuyerEvaluateView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/4.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBuyerEvaluateView.h"

#import "FMEvaluationTotalView.h"
#import "FMGoodsEvaluationView.h"

const CGFloat FMBuyerEvaluateViewHeight = 44.f + 206.f;

@interface FMBuyerEvaluateView ()

@property (nonatomic, strong) FMEvaluationTotalView *evaluationTotalView;

@property (nonatomic, strong) FMGoodsEvaluationView *goodsEvaluationView;


@end

@implementation FMBuyerEvaluateView

#pragma mark - Private Functions

- (void)setViewModel:(FMBuyerEvaluateViewModel *)viewModel {
    _viewModel = viewModel;
    
}

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    [self setupEvaluationTotalView];
    
    [self setupGoodsEvaluationView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupEvaluationTotalView {
    _evaluationTotalView = (FMEvaluationTotalView *)FMEvaluationTotalView.cv_viewFromNibLoad();
    [self addSubview:_evaluationTotalView];
}

- (void)setupGoodsEvaluationView {
    _goodsEvaluationView = (FMGoodsEvaluationView *)FMGoodsEvaluationView.cv_viewFromNibLoad();
    [self addSubview:_goodsEvaluationView];
}

- (void)fm_bindViewModel {
//    @weakify(self);
//
//    [[_arrowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//
//        [self.viewModel.actionSubject sendNext:self.viewModel.model];
//    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [_evaluationTotalView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(FMEvaluationTotalViewHeight);
    }];
    
    [_goodsEvaluationView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(FMEvaluationTotalViewHeight);
        make.width.equalTo(self);
        make.height.equalTo(FMGoodsEvaluationViewHeight);
    }];
    
    [super updateConstraints];
}

@end
