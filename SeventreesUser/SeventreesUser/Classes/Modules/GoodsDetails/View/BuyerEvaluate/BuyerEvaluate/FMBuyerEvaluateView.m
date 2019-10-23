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
    @weakify(self);
    
    [RACObserve(self.viewModel, commentsTotal) subscribeNext:^(NSNumber *commentsTotal) {
        @strongify(self)
        self->_evaluationTotalView.evaluateTotal = commentsTotal.integerValue;
    }];
    
    [RACObserve(self.viewModel, commentsModel) subscribeNext:^(FMGoodsDetailsCommentsModel *commentsModel) {
        @strongify(self)
        self->_goodsEvaluationView.viewModel.commentsModel = commentsModel;
    }];
    
    __weak typeof(self) weakSelf = self;
    _evaluationTotalView.showAllCallback = ^{
        [weakSelf.viewModel.nextActionSubject sendNext:nil];
    };
    
    [_goodsEvaluationView.viewModel.selectItemSubject subscribeNext:^(FMImageEyeModel *imageEyeModel) {
        @strongify(self)
        [self.viewModel.selectItemSubject sendNext:imageEyeModel];
    }];
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

- (FMBuyerEvaluateViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMBuyerEvaluateViewModel alloc] init];
    }
    return _viewModel;
}

@end
