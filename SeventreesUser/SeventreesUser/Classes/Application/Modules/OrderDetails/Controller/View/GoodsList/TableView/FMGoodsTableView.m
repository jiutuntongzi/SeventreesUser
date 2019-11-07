//
//  FMGoodsTableView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsTableView.h"

#import "FMGoodsHeaderView.h"
#import "FMGoodsFooterView.h"
#import "FMGoodsInDetailsCell.h"

@interface FMGoodsTableView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FMGoodsHeaderView *headerView;

@property (nonatomic, strong) FMGoodsFooterView *footerView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation FMGoodsTableView

- (void)fm_setupSubviews {
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = FMGoodsInDetailsCellRowHeight;
    _tableView.backgroundColor = UIColor.cc_colorByHexString(@"#F7F7F7");
}

- (void)fm_bindViewModel {
    
}

#pragma mark - System Functions

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _tableView.frame = self.bounds;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMGoodsInDetailsCell *goodsCell = FMGoodsInDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
    return goodsCell;
    //    cell.goodsModel = self.viewModel.;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath == %@", indexPath);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FMGoodsHeaderView *headerView = FMGoodsHeaderView.cv_viewFromNibLoad();
    headerView.frame = CGRectZero;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMGoodsHeaderViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FMGoodsFooterView *footerView = FMGoodsFooterView.cv_viewFromNibLoad();
    footerView.frame = CGRectZero;
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FMGoodsFooterViewHeight;
}

@end
