//
//  FMSpellListController .m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSpellListController.h"

#import "FMSpellHeaderView.h"
#import "FMGoodsInDetailsCell.h"
#import "FMButtonFooterView.h"

@interface FMSpellListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FMSpellHeaderView *headerView;

@property (nonatomic, strong) FMButtonFooterView *footerView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, assign) NSUInteger pageNo;

@property (nonatomic, assign) NSInteger limit;

@end

@implementation FMSpellListController

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

//- (void)fm_setupNavbar {
//    [super fm_setupNavbar];
//}

- (void)fm_addSubviews {
    _tableView.rowHeight = FMGoodsInDetailsCellRowHeight;
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
    FMGoodsInDetailsCell *goodsCell = FMGoodsInDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
//    cell.goodsModel = self.viewModel.;
    return goodsCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UIViewController *nextVC = [FMOrderDetailsController new];
//    [self.navigationController pushViewController:nextVC animated:YES];
    DLog(@"indexPath == %@", indexPath);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FMSpellHeaderView *headerView = (FMSpellHeaderView *)FMSpellHeaderView.cv_viewFromNibLoad();
    headerView.frame = CGRectZero;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMSpellHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FMButtonFooterView *footerView = (FMButtonFooterView *)FMButtonFooterView.cv_viewFromNibLoad();
    footerView.frame = CGRectZero;
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FMButtonFooterViewHeight;
}

@end
