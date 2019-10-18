//
//  FMStoreInfoView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreInfoView.h"

const CGFloat FMStoreInfoViewHeight = 64.f;

@interface FMStoreInfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *brandImgView;

@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsTotalLabel;

@property (weak, nonatomic) IBOutlet UIButton *arrowButton;

@end

@implementation FMStoreInfoView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMStoreInfoViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMStoreInfoViewModel *)_viewModel;
    
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
    
    [RACObserve(self.viewModel, storeModel) subscribeNext:^(FMStoreInfoModel *storeModel) {
        @strongify(self);
        [self->_brandImgView sd_setImageWithURL:[NSURL URLWithString:storeModel.brandImg]];
        self->_brandNameLabel.text = storeModel.brandName ?: @"--";
        self->_goodsTotalLabel.text = [NSString stringWithFormat:@"共有%@件商品", storeModel.brandGoodsNum];
    }];
    
    [[_arrowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.nextActionSubject sendNext:self.viewModel.storeModel];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMStoreInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMStoreInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
