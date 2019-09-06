//
//  FMBargainGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainGoodsListController.h"
#import "PagingView.h"
#import "FMBargainGoodsCell.h"

@interface FMBargainGoodsListController ()

@end

@implementation FMBargainGoodsListController

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;

    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" params:@{@"userId": @"1059"} requestDataHandler:^(NSDictionary *result) {
//        NSArray *dictArray = [result[@"list"] copy];
//        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
//        return resultEntitys;
        return @[@{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMBargainGoodsCell *cell = FMBargainGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
//        cell.storedRecord = [entitys objectCheckAtIndex:indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
    }];
    self.view.cv_addSubview(pagingView.cv_frame(self.view.bounds));
}

@end
