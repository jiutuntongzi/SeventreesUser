//
//  FMGoodsDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsController.h"

#import "FMGoodsDetailsView.h"
#import "FMGoodsDetailsViewModel.h"

@interface FMGoodsDetailsController ()

@property (nonatomic, strong) FMGoodsDetailsView *mainView;

@end

@implementation FMGoodsDetailsController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    _mainView = [[FMGoodsDetailsView alloc] initWithFrame:self.view.bounds];;
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
