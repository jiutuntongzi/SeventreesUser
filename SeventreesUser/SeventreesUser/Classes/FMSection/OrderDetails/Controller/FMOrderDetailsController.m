//
//  FMOrderDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderDetailsController.h"
#import "FMOrderDetailsViewModel.h"

@interface FMOrderDetailsController ()

@end

@implementation FMOrderDetailsController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)updateViewConstraints {


    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {

}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"订单详情";
}

- (void)fm_refreshData {
//    self.viewModel
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"%@ 订单详情VC销毁了", NSStringFromClass([self class]));
}

@end
