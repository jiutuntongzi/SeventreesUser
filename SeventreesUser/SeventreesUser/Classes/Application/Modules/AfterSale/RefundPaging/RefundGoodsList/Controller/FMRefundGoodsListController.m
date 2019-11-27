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
        
    } cellDidSelectHandler:^(FMRefundOrderModel *refundEntity) {
        DLog(@"refundEntity == %@", refundEntity);
        
        // status: 售后状态 (0等待处理, 1审核不通过, 2审核通过（退货中未填写物流）, 3审核通过（退款中/退货中已填写物流）,退款成功，4商家已验收)
        /*
         NSString *statusText = nil;
         if (refundEntity.status == nil) statusText = @"--";
         
         if (refundEntity.status.integerValue == 1) {
         statusText = @"已驳回";
         } else if (refundEntity.status.integerValue == 2) {
         statusText = @"退款审核通过";
         } else if (refundEntity.status.integerValue == 3) {
         statusText = @"退款中";
         } else if (refundEntity.status.integerValue == 4) {
         statusText = @"商家已验收";
         } else if (refundEntity.status.integerValue == 5) {
         statusText = @"已退款";
         }  else { // refundEntity.status == 0
         statusText = @"退款申请处理中";
         }
         self->_statusLabel.text = statusText;
         */
        [FMAftersaleDetailsController showByPageType:FMAftersaleDetailsControllerStyleRefunding refundId:@(298)];
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
