//
//  FMCollectBrandListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectBrandListController.h"
#import "FMCollectBrandCell.h"

@interface FMCollectBrandListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMCollectBrandListController

- (void)fm_addSubviews {
    UIColor *backColor = UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f);
    self.view.cv_backColor(backColor);
    
    void (^setTableViewBlock)(void) = ^{
        UITableView *tableView = UITableView.ct_tableView();
        self->_tableView = tableView;
        tableView.ct_dataSource(self).ct_delegate(self)\
        .ct_rowHeight(FMCollectBrandCellHeight).ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))\
        .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
        .cv_backColor(backColor);
        tableView.cs_showsVerticalScrollIndicator(NO);
        self.view.cv_addSubview(tableView);
    };
    setTableViewBlock(); // 生成表格
}

- (void)fm_makeConstraints {
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMCollectBrandCell *cell = FMCollectBrandCell.ctc_cellReuseNibLoadForTableView(tableView);
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    
//    FMGoodsDetailsController *nextVC = [[FMGoodsDetailsController alloc] init];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController:nextVC animated:YES];
//
    NSLog(@"indexPath.section == %ld indexPath.row == %ld", indexPath.section, indexPath.row);
}

@end
