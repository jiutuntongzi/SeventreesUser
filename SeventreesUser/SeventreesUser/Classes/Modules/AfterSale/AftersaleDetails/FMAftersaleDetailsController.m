//
//  FMAftersaleDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAftersaleDetailsController.h"

#import "FMRefundHeaderView.h"
#import "FMAftersaleGoodsCell.h"
#import "FMRefundFooterView.h"

@interface FMAftersaleDetailsController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FMRefundHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FMRefundFooterView *footerView;

@end

@implementation FMAftersaleDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)fm_addSubviews {
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

- (void)fm_bindViewModel {
//    FMAftersaleDetailsModel KVO
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"售后详情";
    
    // test
//    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        DLog(@"点了导航栏右");
//        UIViewController *nextVC = [[NSClassFromString(@"FMApplyRefundController") alloc] init];
//        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
    //    self.viewModel
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    FMAftersaleGoodsCell *goodsCell = FMAftersaleGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    //    cell.goodsModel = model;
    return goodsCell;
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
    return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMRefundHeaderView_height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FMRefundFooterView_height;
}


#pragma mark - Lazyload
- (FMRefundHeaderView *)headerView {
    if (! _headerView) {
        _headerView = [[FMRefundHeaderView alloc] initWithStyle:FMRefundHeaderViewStyleRefunding];
    }
    return _headerView;
}

- (FMRefundFooterView *)footerView {
    if (! _footerView) {
        _footerView = [FMRefundFooterView new];
    }
    return _footerView;
}

- (void)dealloc {
    DLog(@"%@ VC销毁了", NSStringFromClass([self class]));
}

@end
