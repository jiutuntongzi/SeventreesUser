//
//  FMBrandGoodsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBrandGoodsController.h"

#import "FMBrandGoodsView.h"
#import "FMBrandGoodsViewModel.h"

@interface FMBrandGoodsController ()

@property (nonatomic, strong) FMBrandGoodsView *mainView;

@end

@implementation FMBrandGoodsController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMBrandGoodsView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"品牌商品";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(nil, 1, ^(UIBarButtonItem *rightItem) {
        weakSelf.navigationController.cnc_popViewControllerDidAnimated(YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
    [_mainView.viewModel.refreshUISubject sendNext:nil];
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
