//
//  FMRefundGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundGoodsListController.h"
#import "PagingView.h"
#import "FMRefundInGoodsCell.h"



@interface FMRefundGoodsListController ()

@end

@implementation FMRefundGoodsListController

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;

    // FMRefundInGoodsCellRowHeight 动态组高
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:FMRefundInGoodsCellRowHeight params:@{@"userId": @"1059"} requestDataHandler:^(NSDictionary *result) {
//        NSArray *dictArray = [result[@"list"] copy];
//        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
//        return resultEntitys;
        return @[@{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMRefundInGoodsCell *cell = FMRefundInGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
        cell.ctc_selectionStyle(0); // UITableViewCellSelectionStyleNone
//        cell.viewModel.RefundGoodsListModel
//        cell.storedRecord = [entitys objectCheckAtIndex:indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
      //  FMRefundGoodsDetailsController *nextVC = [[FMRefundGoodsDetailsController alloc] init];
       // nextVC.type = FMRefundGoodsDetailsPageStyleWaitPay;
       // [self.navigationController pushViewController:nextVC animated:YES];
    }];
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f));
    pagingView.cv_backColorByHexString(@"#F7F7F7");
    self.view.cv_addSubview(pagingView);
}

@end
