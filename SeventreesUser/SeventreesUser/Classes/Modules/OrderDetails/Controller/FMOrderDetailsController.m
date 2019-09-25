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
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) FMOrderStatusView *orderStatusView;
@property (nonatomic, strong) FMOrderAddressView *addressView;

@property (nonatomic, strong) FMGoodsTableView *goodsListView;
@property (nonatomic, strong) FMOrderExplainView *orderExplainView;
@property (nonatomic, strong) FMOrderContactUsView *contactUsView;

@property (nonatomic, strong) FMOrderPayView *orderPayView;

@end

@implementation FMOrderDetailsController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _orderPayView = FMOrderPayView.cv_viewFromNibLoad();
    [self.view addSubview:_orderPayView];
    
    [self setupMainScrollView];
    [self setupScrollerContent];
    
    [self fm_makeConstraints];
}

/** Main Scroller */
- (void)setupMainScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = YES;
    scrollView.backgroundColor = UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f);
    scrollView.contentSize = CGSizeMake(0.f, 795.f);
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = true;
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mainScrollView = scrollView;
    [self.view addSubview:_mainScrollView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = scrollView.backgroundColor;
    [_mainScrollView addSubview:_contentView];
}

- (void)setupScrollerContent {
    // 订单状态
    _orderStatusView = FMOrderStatusView.cv_viewFromNibLoad();
    [_contentView addSubview:_orderStatusView];
    
    // 位置地址
    _addressView = FMOrderAddressView.cv_viewFromNibLoad();
    [_contentView addSubview:_addressView];
    
    // 商品信息
    _goodsListView = FMGoodsTableView.cv_viewFromNibLoad();
    [_contentView addSubview:_goodsListView];
    
    // 订单详细信息
    _orderExplainView = FMOrderExplainView.cv_viewFromNibLoad();
    [_contentView addSubview:_orderExplainView];
    
    // 联系导购\客服
    _contactUsView = FMOrderContactUsView.cv_viewFromNibLoad();
    [_contentView addSubview:_contactUsView];
}

- (void)setupOrderPayView {
    
}

- (void)fm_makeConstraints {
    [_orderPayView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(FMOrderPayViewHeight);
    }];
    
    [_mainScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-FMOrderPayViewHeight);
    }];
    
    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self->_mainScrollView);
        make.width.equalTo(self->_mainScrollView);
        make.height.equalTo(795.f);
    }];
    
    /// subviewContents
    const CGFloat margin = 15.f;
    CGFloat offsetY = 0.f;
    
    [_orderStatusView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMOrderStatusViewHeight);
    }];
    
    offsetY += FMOrderStatusViewHeight;
    [_addressView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMOrderAddressViewHeight);
    }];
    
    offsetY += (FMOrderAddressViewHeight + margin);
    [_goodsListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMGoodsTableViewHeight);
    }];
    
    offsetY += (FMGoodsTableViewHeight + margin);
    [_orderExplainView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
//        make.top.equalTo(self->_goodsListView.bottom).offset(margin);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMOrderExplainViewHeight);
    }];
    
    offsetY += FMOrderExplainViewHeight;
    [_contactUsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
//        make.top.equalTo(self->_orderExplainView.bottom).offset(margin);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMOrderContactUsViewHeight);
    }];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"订单详情";
    
    // test
        __weak typeof(self) weakSelf = self;
        UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
            DLog(@"点了导航栏右");
            
            UIViewController *nextVC = [[NSClassFromString(@"FMApplyRefundController") alloc] init];
            weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
        });
        self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
//    self.viewModel
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"%@ 订单详情VC销毁了", NSStringFromClass([self class]));
}

@end
