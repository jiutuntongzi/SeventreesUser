//
//  FMStoreConsumeController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreConsumeController.h"
#import "FMFragmentBarView.h"

#import "StoreConsumeHeader.h"

@interface FMStoreConsumeController () <UITableViewDataSource, UITableViewDelegate>

/// header
//@property (nonatomic, strong) FMConsumeHeaderView *headerView;

/// footer
//@property (nonatomic, strong) FMTotalFooterView *footerView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, assign) NSUInteger pageNo;

@property (nonatomic, assign) NSInteger limit;

@end

@implementation FMStoreConsumeController

- (NSMutableArray *)dataSources {
    if (! _dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}

- (instancetype)init {
    if (self = [super init]) {
        _limit = 10;
        _pageNo = 1;
    }
    return self;
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    FMFragmentBarView *fragmentBarView = (FMFragmentBarView *)FMFragmentBarView.cv_viewFromNibLoad();
    fragmentBarView.type = 1;
    fragmentBarView.frame = CGRectMake(0.f, 0.f, 200.f, 30.f);
    self.navigationItem.titleView = fragmentBarView;
    
    __weak typeof(self) weakSelf = self;
    fragmentBarView.actionCallback = ^(UInt8 type) {
        if (type == 0) [weakSelf.navigationController popViewControllerAnimated:NO];
    };
}

- (void)fm_addSubviews {
    _tableView.rowHeight = FMServerConsumeCellHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf execPullDownRefresh];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf execUpPullLoad];
    }];
}

- (void)fm_refreshData {
    [self requestRefreshData:NO];
}

- (void)execPullDownRefresh {
    _pageNo = 1;
    [self requestRefreshData:NO];
}

- (void)execUpPullLoad {
    ++ _pageNo;
    [self requestRefreshData:YES];
}

- (void)requestRefreshData:(BOOL)isLoadMore {
    NSMutableDictionary *mParams = [[NSMutableDictionary alloc] initWithCapacity:2];
    mParams[@"page"] = @(_pageNo);
    mParams[@"limit"] = @(_limit);
    [mParams copy];
    [self endRefreshingAnima];
}

- (void)endRefreshingAnima {
    [_tableView.mj_footer endRefreshing];
    [_tableView.mj_header endRefreshing];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section % 2 == 0) {
        FMGoodsInDetailsCell *goodsCell = FMGoodsInDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
        return goodsCell;
    } else {
        FMServerConsumeCell *serverCell = FMServerConsumeCell.ctc_cellReuseNibLoadForTableView(tableView);
        return serverCell;
    }
    //    cell.goodsModel = self.viewModel.;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath == %@", indexPath);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FMConsumeHeaderView *headerView = (FMConsumeHeaderView *)FMConsumeHeaderView.cv_viewFromNibLoad();
    headerView.frame = CGRectZero;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMConsumeHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FMTotalFooterView *footerView = (FMTotalFooterView *)FMTotalFooterView.cv_viewFromNibLoad();
    footerView.frame = CGRectZero;
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FMTotalFooterViewHeight;
}

@end
