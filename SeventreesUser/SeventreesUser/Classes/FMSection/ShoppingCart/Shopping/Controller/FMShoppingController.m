//
//  FMShoppingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingController.h"
#import "FMShoppingView.h"

@interface FMShoppingController ()

@property (nonatomic, strong) FMShoppingView *mainView;

@end

@implementation FMShoppingController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateViewConstraints {
    _mainView.frame = self.view.bounds;
//    [_mainView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMShoppingView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    @weakify(self);
    [_mainView.viewModel.settleActionSubject subscribeNext:^(id x) {
        @strongify(self);
        self.navigationController.cnc_pushViewControllerDidAnimated([[NSClassFromString(@"FMPayController") alloc] init], YES);
    }];
}

- (void)fm_setupNavbar {
    
    self.navigationItem.title = @"购物车";
    
    __weak typeof(self) weakSelf = self;
    
    // test
    UIBarButtonItem *leftItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"拼团专区", 1, ^(UIBarButtonItem *leftItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMSpellGroupController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_leftBarButtonItem(leftItem);
    
    // test
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"品牌商品", 1, ^(UIBarButtonItem *leftItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMBrandGoodsController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
    
//    self.navigationItem.rightBarButtonItem.title = @"";
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload

@end
