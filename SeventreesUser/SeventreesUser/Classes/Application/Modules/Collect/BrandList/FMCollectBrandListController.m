//
//  FMCollectBrandListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectBrandListController.h"
#import "FMCollectBrandCell.h"

#import "FMBrandGoodsController.h"

@interface FMCollectBrandListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMCollectBrandListController

- (void)fm_addSubviews {
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
    
    UIColor *backColor = UIColor.cc_colorByHexString(@"#F7F7F7");
    self.view.cv_backColor(backColor);
    
    void (^setTableViewBlock)(void) = ^{
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        self->_tableView = tableView;
        tableView.dataSource = self; tableView.delegate = self;
        tableView.ct_rowHeight(FMCollectBrandCellHeight).ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))\
        .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
        .cv_backColor(backColor);
        tableView.cs_showsVerticalScrollIndicator(NO);
        self.view.cv_addSubview(tableView);
    };
    setTableViewBlock(); // 生成表格
}

- (void)fm_makeConstraints {
    _tableView.frame = self.view.bounds;
    
//    [_tableView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
////        make.left.right.top.equalTo(self.view);
////        make.bottom.equalTo(self.view).offset(- kNavBarHeight - kTabBarHeight - kFixedHeight);
//    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [[self.viewModel rac_valuesAndChangesForKeyPath:@"searchText" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
//        NSString *searchText = tuple.first; // newValue
//        if (! searchText) {
//            [SVProgressHUD showInfoWithStatus:@"输入不能为空"];
//            return;
//        }
        [self.viewModel.requestDataCommand execute:nil];
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        [self->_tableView reloadData];
        if (! resultModel.isSuccess) {
            [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
        }
    }];
    
    [UIView showRequestHUDStatus:@"搜索中.." command:self.viewModel.requestDataCommand];
    
    [self.viewModel.refreshBrandUISubject subscribeNext:^(id x) {
        @strongify(self)
        [self->_tableView reloadData];
    }];
}

- (void)fm_refreshData {
    [self.viewModel.requestBrandDataCommand execute:nil];
}

- (FMCollectBrandListViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMCollectBrandListViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMCollectBrandCell *cell = FMCollectBrandCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.brandModel = self.viewModel.brandEntitys[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.brandEntitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    FMBrandGoodsController *nextVC = [[FMBrandGoodsController alloc] init];
    nextVC.brandId = self.viewModel.brandEntitys[indexPath.row].brandId;
    self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
}

@end
