//
//  FMPayController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPayController.h"
#import "FMPayView.h"

@interface FMPayController ()

@property (nonatomic, strong) FMPayView *mainView;

@end

@implementation FMPayController

#pragma mark - System Functions

- (void)updateViewConstraints {
//    _mainView.frame = self.view.bounds;
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = FMPayView.cv_viewFromNibLoad();
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
//    FMPayController
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"提交订单";
}

- (void)fm_refreshData {
    _mainView.viewModel.orderId = self->_orderId;
    
    [_mainView.viewModel.requestDataCommand execute:nil];
}

#pragma mark - Lazyload

@end
