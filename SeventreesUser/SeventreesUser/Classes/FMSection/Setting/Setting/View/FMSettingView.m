//
//  FMSettingView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettingView.h"
#import "FMSelectItemCell.h"

@interface FMSettingView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat rowHeight;

@property (strong, nonatomic) UIButton *logoutButton;

@end

@implementation FMSettingView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    _rowHeight = 44.f;
    self.cv_backColor(UIColor.whiteColor);
    
    [self setupTableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupTableView {
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    UITableView *tableView = UITableView.ct_tableViewWithFrameStyle(0.f, 0.f, width, height, UITableViewStylePlain)\
    .ct_dataSource(self).ct_delegate(self)\
    .ct_rowHeight(_rowHeight).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#EEEEEE"))\
    .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)); // .ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))
    tableView.cv_backColorByHexString(@"#F7F7F7");
    tableView.bounces = NO;
    self->_tableView = tableView;
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        [self->_pagingUtility execPullDownRefresh];
//    }];
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////        [self->_pagingUtility execUpPullLoad];
//    }];
    
    [self addSubview:tableView];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);

        [self.viewModel.logoutActionSubject sendNext:nil];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self); // make.left.right.top.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMSettingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSettingViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMSelectItemCell *cell = FMSelectItemCell.ctc_cellReuseNibLoadForTableView(tableView);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"点了第%ld行", indexPath.row);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.cv_backColor(UIColor.clearColor);
    [headerView addSubview:self.logoutButton];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _rowHeight + 20.f;
}

- (UIButton *)logoutButton {
    if (! _logoutButton) {
        CGFloat margin = 14.f;
        UIButton *button = UIButton.cb_button().cb_title(@"退出登录").cb_fontSize(15.f).cb_titleColor(UIColor.whiteColor);
        _logoutButton = button;
        button.cv_frameOf(margin, 20.f, kScreenWidth - margin * 2.f, _rowHeight).cv_backColor(UIColor.cc_colorByHexString(@"#F76F6F"));
        button.layer.cornerRadius = 5.f;
    }
    return _logoutButton;
}

@end
