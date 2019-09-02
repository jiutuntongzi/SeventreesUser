//
//  FMStoreIntroView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreIntroView.h"

@interface FMStoreIntroView ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) UIView *view;

@end

@implementation FMStoreIntroView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMStoreIntroViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMStoreIntroViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {
    
    
//    self.cv_addSubviews(@[nil, nil]);
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

        [self.viewModel.actionSubject sendNext:nil];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMStoreIntroViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMStoreIntroViewModel alloc] init];
    }
    return _viewModel;
}

@end
