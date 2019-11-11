//
//  FMCouponListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponListController.h"
#import "FMCouponCell.h"

@interface FMCouponListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMCouponListController

- (void)fm_addSubviews {
//    self.view.bounds = CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f);
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
    
    UIColor *backColor = UIColor.cc_colorByHexString(@"#F7F7F7");
    self.view.cv_backColor(backColor);
    
    void (^setTableViewBlock)(void) = ^{
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        self->_tableView = tableView;
        tableView.dataSource = self; tableView.delegate = self;
        tableView.ct_rowHeight(FMCouponCellRowHeight).ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))\
        .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
        .cv_backColor(backColor);
        tableView.cs_showsVerticalScrollIndicator(NO);
        self.view.cv_addSubview(tableView);
    };
    setTableViewBlock(); // 生成表格
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        [self->_tableView reloadData];
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
}

- (FMCouponListViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMCouponListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)fm_refreshData {
    [self.viewModel.requestDataCommand execute:nil];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMCouponCell *cell = FMCouponCell.ctc_cellReuseNibLoadForTableView(tableView);
    FMCouponCellViewModel *viewModel = [[FMCouponCellViewModel alloc] init];
    viewModel.couponEntity = self.viewModel.couponEntitys[indexPath.row];
    cell.viewModel = viewModel;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.couponEntitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
//    self.navigationController.cnc_pushViewControllerDidAnimated([FMCouponListController new], YES);
}


@end
