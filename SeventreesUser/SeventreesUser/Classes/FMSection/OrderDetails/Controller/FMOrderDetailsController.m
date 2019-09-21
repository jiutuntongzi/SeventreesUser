//
//  FMOrderDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderDetailsController.h"
#import "FMOrderDetailsViewModel.h"

#import "OrderDetailsHeader.h"

@interface FMOrderDetailsController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) FMOrderStatusView *orderStatusView;

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
    [self setupMainScrollView];
    
    [self setupScrollerContent];
}

/** Main Scroller */
- (void)setupMainScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.bounces = YES;
    scrollView.backgroundColor = UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f);
    scrollView.contentSize = CGSizeMake(0.f, 2130.f);
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView = scrollView;
    [self.view addSubview:_mainScrollView];
}

- (void)setupScrollerContent {
    // 订单状态
    
    
    
    _orderStatusView = FMOrderStatusView.cv_viewFromNibLoad();
    [_mainScrollView addSubview:_orderStatusView];
}

- (void)fm_makeConstraints {
    [_mainScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-FMOrderPayViewHeight);
    }];
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
