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
@property (nonatomic, assign) CGFloat margin;


@property (nonatomic, strong) FMOrderStatusView *orderStatusView;
@property (nonatomic, strong) FMOrderAddressView *addressView;

@property (nonatomic, strong) FMGoodsTableView *goodsListView;
@property (nonatomic, strong) FMOrderExplainView *orderExplainView;
@property (nonatomic, strong) FMOrderContactUsView *contactUsView;

@property (nonatomic, strong) FMOrderPayView *orderPayView;

@property (nonatomic, strong) FMOrderDetailsViewModel *viewModel;


@end

@implementation FMOrderDetailsController

#pragma mark - System Functions

+ (void)showByType:(FMOrderDetailsPageStyle)type orderId:(NSNumber *)orderId fromController:(UIViewController *)fromVC {
    FMOrderDetailsController *nextVC = [[self alloc] init];
    nextVC.orderId = orderId;
    nextVC.type = type;
    fromVC.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    [self setupMainScrollView];
    [self setupScrollerContent];
    
    [self setupOrderPayView];
}

/** Main Scroller */
- (void)setupMainScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = YES;
    scrollView.backgroundColor = UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f);
    scrollView.contentSize = CGSizeMake(0.f, [self contentVHeight]);
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0.f, [self contentVHeight] + FMOrderPayViewHeight);
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (@available(iOS 11.0, *)) scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
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

/** 订单工具：底部单独的 */
- (void)setupOrderPayView {
    _orderPayView = FMOrderPayView.cv_viewFromNibLoad();
    _orderPayView.hidden = YES;
    [self.view addSubview:_orderPayView];
}

#pragma mark - Make Constraints

/** 拿到商品列表数据后，更新ScrollView内容布局 */
- (void)updateConstraintsForScrollerContentHeight {
    CGFloat dynamicHeight = [self dynamicContentVHeight];
    
    CGFloat orderPayViewHeight = FMOrderPayViewHeight;
    if (self.viewModel.orderDetailsEntity.orderStatus.integerValue == 9) orderPayViewHeight = 0.f; // 订单取消
    _mainScrollView.contentSize = CGSizeMake(0.f, dynamicHeight + orderPayViewHeight); // 动态更新ScrollView内容高度
    
    [_contentView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(dynamicHeight); // 动态内容高度
    }];

    CGFloat tableViewHeight = FMGoodsTableViewHeight + [self goodsListHeight];
    [_goodsListView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(tableViewHeight);
    }];
    
    const CGFloat _margin = 15.f;
    CGFloat offsetY = FMOrderStatusViewHeight + (FMOrderAddressViewHeight + _margin) + (tableViewHeight + _margin);
    [_orderExplainView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
    }];

    offsetY += FMOrderExplainViewHeight;
    [_contactUsView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
    }];
}

/** 动态计算ScrollView内容高度 */
- (CGFloat)dynamicContentVHeight {
    return [self contentVHeight] + [self goodsListHeight]; // 求出contentView动态高度
}

/** 商品列表高度（减去TableView头部、尾部的商品表格s高度）*/
- (CGFloat)goodsListHeight {
    return self.viewModel.orderDetailsEntity.goodsEntitys.count * FMGoodsTableViewRowHeight;
}

/** Scroller contentView默认高度 （default = 576.f） */
- (CGFloat)contentVHeight {
    CGFloat offsetY = 0.f;
    
    offsetY += FMOrderStatusViewHeight;
    offsetY += (FMOrderAddressViewHeight + _margin);
    offsetY += (FMGoodsTableViewHeight + _margin); // 减去TableView高度
    offsetY += FMOrderExplainViewHeight;
    offsetY += FMOrderContactUsViewHeight;
//    DLog(@"contentView默认高度 == %f", offsetY);
    return offsetY;
}

- (void)fm_makeConstraints {
    [_orderPayView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.height.equalTo(FMOrderPayViewHeight);
    }];
    
    [_mainScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self->_mainScrollView);
        make.height.equalTo([self contentVHeight]); // 默认高度
    }];
    
    /// subviewContents
    CGFloat offsetY = 0.f;  _margin = 15.f;
    
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
    
    offsetY += (FMOrderAddressViewHeight + _margin);
    [_goodsListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMGoodsTableViewHeight);
    }];
    
    offsetY += (FMGoodsTableViewHeight + _margin);
    [_orderExplainView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
//        make.top.equalTo(self->_goodsListView.bottom).offset(_margin);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMOrderExplainViewHeight);
    }];
    
    offsetY += FMOrderExplainViewHeight;
    [_contactUsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
//        make.top.equalTo(self->_orderExplainView.bottom).offset(_margin);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMOrderContactUsViewHeight);
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [self.viewModel.refreshUISubject subscribeNext:^(FMOrderDetailsModel *orderDetailsEntity) {
        @strongify(self)
        
        [self updateConstraintsForScrollerContentHeight]; // 动态更新内容高度
        
        self->_orderStatusView.orderStatus = orderDetailsEntity.orderStatus;
        self->_orderStatusView.remainTime = orderDetailsEntity.remainTime;
        self->_orderStatusView.createOrderTime = orderDetailsEntity.createOrderTime;
        
        self->_addressView.userName = orderDetailsEntity.addressUserName;
        self->_addressView.mobilePhone = orderDetailsEntity.addressMobile;
        self->_addressView.addressDetails = orderDetailsEntity.addressName;
        
        self->_goodsListView.orderDetailsEntity = orderDetailsEntity;
        
        self->_orderExplainView.orderExplainEntity = orderDetailsEntity.orderExplainEntity;
        
        self->_orderPayView.viewModel.orderStatus = orderDetailsEntity.orderStatus;
        self->_orderPayView.viewModel.orderId = orderDetailsEntity.orderId;
    }];
    
    [UIView showStatusInfoBySubject:_viewModel.showHintSubject];
    
    [self.orderPayView.viewModel.reloadDataSubject subscribeNext:^(NSNumber *orderId) {
        @strongify(self)
        [self.viewModel.requestDataCommand execute:nil];
    }];
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
    self.viewModel.orderId = self->_orderId;
    [self.viewModel.requestDataCommand execute:nil];
}

#pragma mark - Lazyload

- (FMOrderDetailsViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMOrderDetailsViewModel alloc] init];
    }
    return _viewModel;
}

@end
