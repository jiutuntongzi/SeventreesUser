//
//  FMAftersaleDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAftersaleDetailsController.h"
#import "FMAftersaleDetailsViewModel.h"

#import "FMRefundHeaderView.h"
#import "FMAftersaleGoodsCell.h"
#import "FMRefundFooterView.h"

@interface FMAftersaleDetailsController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) FMAftersaleDetailsControllerStyle pageType;

@property (nonatomic, strong) FMRefundHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FMRefundFooterView *footerView;

@property (nonatomic, strong) FMAftersaleDetailsViewModel *viewModel;

@end

@implementation FMAftersaleDetailsController

+ (void)showByPageType:(FMAftersaleDetailsControllerStyle)type refundId:(NSNumber *)refundId {
    FMAftersaleDetailsController *nextVC = self.cvc_controller();
    nextVC.pageType = type;
    nextVC.viewModel.refundId = refundId;
    commonMgr.topViewController().cvc_pushViewController(nextVC);
}

- (void)fm_addSubviews {
    [self headerView]; // 先做初始化，用Style计算高度(FMRefundHeaderView_height)
    [self footerView]; // 先做初始化，用Style计算高度(FMRefundFooterView_height)
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = YES;
    _tableView.backgroundColor = UIColor.cc_colorByHexString(@"#F7F7F7");
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = FMAftersaleGoodsCell_height;
//    _tableView.tableHeaderView = self.headerView; // 不显示Cell
//    _tableView.sectionHeaderHeight = FMRefundHeaderView_height;
    
    NSString *cellClassName = NSStringFromClass([FMAftersaleGoodsCell class]);
    [_tableView registerNib:[UINib nibWithNibName:cellClassName bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellClassName];
    
    [self.view addSubview:_tableView];
}

- (void)fm_makeConstraints {
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self.viewModel, refundEntity) subscribeNext:^(FMAftersaleDetailsModel *refundEntity) {
        @strongify(self)
        [self->_tableView reloadData];
    }];
    
    [UIView showStatusInfoBySubject:self.viewModel.showHintSubject];
}

- (void)fm_bindViewModel {

}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"售后详情";
}

- (void)fm_refreshData {
    [self.viewModel.requestDataCommand execute:nil];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMAftersaleGoodsCell *cell = FMAftersaleGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.goodsEntity = self.viewModel.refundEntity.goodsEntitys[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // 写死一组
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.refundEntity.goodsEntitys.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"点了商品Cell：%@", self.viewModel.refundEntity.goodsEntitys);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.headerView.refundEntity = self.viewModel.refundEntity;
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMRefundHeaderView_height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    self.footerView.explainEntity = self.viewModel.refundEntity.explainEntity;
    return self.footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FMRefundFooterView_height;
}

#pragma mark - Lazyload

- (FMAftersaleDetailsViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMAftersaleDetailsViewModel alloc] init];
    }
    return _viewModel;
}

- (FMRefundHeaderView *)headerView {
    if (! _headerView) {
        _headerView = [[FMRefundHeaderView alloc] initWithStyle:(FMRefundHeaderViewStyle)_pageType];
    }
    return _headerView;
}

- (FMRefundFooterView *)footerView {
    if (! _footerView) {
        UInt8 footerStyle = 0;
        if (_pageType == FMAftersaleDetailsControllerStyleWaitReceive ||
            _pageType == FMAftersaleDetailsControllerStyleSalesSuccess ||
            _pageType == FMAftersaleDetailsControllerStyleSalesFailure
            ) {
            footerStyle = 1;
        }
        _footerView = [[FMRefundFooterView alloc] initWithStyle:footerStyle];
    }
    return _footerView;
}

@end
