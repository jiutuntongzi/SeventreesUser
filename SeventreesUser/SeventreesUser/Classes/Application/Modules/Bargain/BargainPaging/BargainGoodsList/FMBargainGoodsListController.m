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

    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:152.f params:@{@"userId": @"1059"} requestDataHandler:^(NetworkResultModel *resultModel) {
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
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f));
    self.view.cv_addSubview(pagingView);
}

- (void)updateViewConstraints {
    [super updateViewConstraints];

    
}

@end
