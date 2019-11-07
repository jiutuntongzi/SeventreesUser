//
//  FMPayView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPayView.h"

@interface FMPayView ()


@end

@implementation FMPayView

#pragma mark - System Functions

- (instancetype)initWithViewModel:(id<FMViewModelProtocol>)viewModel {
    _viewModel = (FMPayViewModel *)viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
 
    [super updateConstraints];
}


#pragma mark - Private Functions

- (void)fm_setupSubviews {

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


- (void)fm_bindViewModel {

}

- (void)refreshUI {
    
}

#pragma mark - Lazyload

- (FMPayViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMPayViewModel alloc] init];
    }
    return _viewModel;
}

@end
