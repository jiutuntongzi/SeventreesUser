//
//  FMEvaluationController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMEvaluationController.h"
#import "FMEvaluationView.h"

@interface FMEvaluationController ()

@property (nonatomic, strong) FMEvaluationView *mainView;

@end

@implementation FMEvaluationController

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMEvaluationView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"商品评价";
}

- (void)fm_refreshData {
    [_mainView.viewModel.requestDataCommand execute:_goodsId];
}

#pragma mark - System Functions

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

@end
