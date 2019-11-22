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

@property (nonatomic, strong) PagingView *pagingView;

@end

@implementation FMBargainGoodsListController

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    params[@"categoryId"] = self.categoryId;
    params[@"activityType"] = self.activityType;
    params[@"order"] = @(1); // 排列顺序（1 = 正序 2 = 逆序）
    
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:kCategoryGoodsListQueryURIPath rowHeight:FMBargainGoodsCellRowHeight params:params requestDataHandler:^(NetworkResultModel *resultModel) {

        if (![resultModel.statusCode isEqualToString:@"OK"]) [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
        
        NSArray *goodsEntitys = [[FMCategoryGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"goodsModels"]] copy];
        return goodsEntitys;
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *goodsEntitys) {
        FMBargainGoodsCell *cell = FMBargainGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
        cell.goodsEntity = goodsEntitys[indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(FMCategoryGoodsModel *goodsEntity) {
        DLog(@"goodsEntity == %@", goodsEntity);
    }];
    
    self.view.cv_addSubview(pagingView);
}

- (void)fm_makeConstraints {
//    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
//    _pagingView.cv_frame(self.view.bounds);
    _pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f));
}

- (void)fm_refreshData {
    [_pagingView requestData];
}

@end
