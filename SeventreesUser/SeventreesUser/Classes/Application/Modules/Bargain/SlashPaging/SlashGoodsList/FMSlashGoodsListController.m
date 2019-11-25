//
//  FMSlashGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashGoodsListController.h"
#import "PagingView.h"
#import "FMSlashGoodsCell.h"

#import "FMSlashDetailsController.h"

@interface FMSlashGoodsListController ()

@end

@implementation FMSlashGoodsListController

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;

    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:FMSlashGoodsCellHeight params:@{@"userId": @"1059"} requestDataHandler:^(NetworkResultModel *resultModel) {
//        NSArray *dictArray = [result[@"list"] copy];
//        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
//        return resultEntitys;
        return @[@{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMSlashGoodsCell *cell = FMSlashGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
//        cell.viewModel.goodsModel =
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
        
//        [FMSlashDetailsController showByPageType:FMSlashDetailsControllerStyleSlashing activityId:<#(NSNumber *)#> goodsId:<#(NSNumber *)#>]
        
    }];
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f));
    pagingView.cv_backColorByHexString(@"#f7f7f7");
    self.view.cv_addSubview(pagingView);
}

@end
