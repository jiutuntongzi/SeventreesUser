//
//  FMSpellShopCarToolView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSpellShopCarToolView.h"

const CGFloat FMSpellShopCarToolViewHeight = 44.f;

@interface FMSpellShopCarToolView ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation FMSpellShopCarToolView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

//- (void)setViewModel:(FMSpellShopCarToolViewModel *)viewModel {
//    _viewModel = viewModel;
//
//
//}
//
//- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
//    _viewModel = (FMSpellShopCarToolViewModel *)_viewModel;
//
//    return [super initWithViewModel:viewModel];
//}

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
        
        
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMSpellShopCarToolViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSpellShopCarToolViewModel alloc] init];
    }
    return _viewModel;
}


@end
