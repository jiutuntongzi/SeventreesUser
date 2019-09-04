//
//  FMShopCarToolView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShopCarToolView.h"

const CGFloat FMShopCarToolViewHeight = 44.f;

@interface FMShopCarToolView ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation FMShopCarToolView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMShopCarToolViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMShopCarToolViewModel *)_viewModel;
    
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
    
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel.actionSubject sendNext:self.viewModel.model];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMShopCarToolViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMShopCarToolViewModel alloc] init];
    }
    return _viewModel;
}


@end
