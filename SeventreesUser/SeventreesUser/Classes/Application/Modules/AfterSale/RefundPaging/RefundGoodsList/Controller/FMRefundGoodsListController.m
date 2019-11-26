//
//  FMRefundGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundGoodsListController.h"
#import "PagingView.h"
#import "FMRefundOrderCell.h"

#import "FMAftersaleDetailsController.h"

@interface FMRefundGoodsListController ()

@property (nonatomic, copy) NSArray<FMRefundOrderModel *> *refundEntitys;


@property (nonatomic, strong) PagingView *pagingView;

@end

@implementation FMRefundGoodsListController

- (void)fm_addSubviews {
    MJWeakSelf
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
    params[@"type"] = @(self->_pageType);
    // FMRefundOrderCellRowHeight 动态组高：0
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:kAfterSalesListQueryURIPath rowHeight:0 params:params requestDataHandler:^(NetworkResultModel *resultModel) {
        weakSelf.refundEntitys = [[FMRefundOrderModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        return weakSelf.refundEntitys;
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *refundEntitys) {
        FMRefundOrderCell *cell = FMRefundOrderCell.ctc_cellReuseNibLoadForTableView(tableView);
        cell.refundEntity = refundEntitys[indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
        FMAftersaleDetailsController *nextVC = [[FMAftersaleDetailsController alloc] init];
        nextVC.pageType = FMAftersaleDetailsControllerStyleRefunding;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    _pagingView = pagingView;
    pagingView.cv_backColorByHexString(@"#F7F7F7");
    self.view.cv_addSubview(pagingView);
}

- (void)fm_makeConstraints {
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
    _pagingView.cv_frame(self.view.bounds);
}

- (void)fm_refreshData {
    [_pagingView requestData];
}

@end
