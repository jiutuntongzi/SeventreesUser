//
//  FMOrderListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderListController.h"
#import "PagingView.h"
#import "FMOrderCell.h"
#import "FMOrderDetailsController.h"



@interface FMOrderListController ()

@end

@implementation FMOrderListController

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;

    // FMOrderCellRowHeight 动态组高
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:FMOrderCellRowHeight params:@{@"userId": @"1059"} requestDataHandler:^(NetworkResultModel *resultModel) {
//        NSArray *dictArray = [result[@"list"] copy];
//        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
//        return resultEntitys;
        return @[@{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMOrderCell *cell = FMOrderCell.ctc_cellReuseNibLoadForTableView(tableView);
//        cell.viewModel.orderListModel
//        cell.storedRecord = [entitys objectCheckAtIndex:indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
        FMOrderDetailsController *nextVC = [[FMOrderDetailsController alloc] init];
        nextVC.type = FMOrderDetailsPageStyleWaitPay;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f));
    self.view.cv_addSubview(pagingView);
    
}

@end