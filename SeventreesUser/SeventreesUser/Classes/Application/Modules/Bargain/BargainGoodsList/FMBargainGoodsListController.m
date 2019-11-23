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

#import "FMBargainDetailsController.h"
#import "FMGoodsDetailsController.h"

@interface FMBargainGoodsListController ()

@property (nonatomic, strong) PagingView *pagingView;

@end

@implementation FMBargainGoodsListController

- (void)fm_addSubviews {
    MJWeakSelf

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    params[@"categoryId"] = self.categoryId;
    params[@"activityType"] = self.activityType;
    params[@"order"] = @(1); // 排列顺序（1 = 正序 2 = 逆序）
    
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:kCategoryGoodsListQueryURIPath rowHeight:FMBargainGoodsCellRowHeight params:params requestDataHandler:^(NetworkResultModel *resultModel) {
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
            [SVProgressHUD dismissWithDelay:1.f];
        }
        
        /// test
        FMCategoryGoodsModel *goodsEntity = [[FMCategoryGoodsModel alloc] init];
        goodsEntity.activityType = kActivityTypeBargain;
        goodsEntity.imgUrl = @"http://img4.imgtn.bdimg.com/it/u=2450762310,3796798634&fm=26&gp=0.jpg";
        goodsEntity.activityId = @(321);
        goodsEntity.name = @"测试商品名字：潜藏魂牵魂牵梦萦魂牵梦萦1234123jk中东地区啫喱咬牙切齿";
        goodsEntity.normalPrice = @(99.88);
        goodsEntity.retailPrice = @(100.00);
        goodsEntity.num = @(3);
        goodsEntity.stock = @(123);
        NSArray *goodsEntitys = @[goodsEntity, goodsEntity, goodsEntity, goodsEntity];
        
        /*
        NSArray *goodsEntitys = [[FMCategoryGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"goodsModels"]] copy];
        */
        return goodsEntitys;
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *goodsEntitys) {
        FMBargainGoodsCell *cell = FMBargainGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
        cell.goodsEntity = goodsEntitys[indexPath.row];
        cell.goBargainActionCallback = ^(FMCategoryGoodsModel * _Nullable goodsEntity) {
            DLog(@"点了去砍价->砍价详情 /api/spactivity/activityInfo");
            /*
            FMBargainDetailsController *nextVC = FMBargainDetailsController.cvc_controller();
            nextVC.goodsId = goodsEntity.goodsId;
            nextVC.activityId = goodsEntity.activityId;
            weakSelf.cvc_pushViewController(nextVC);
            */
            [FMBargainDetailsController showByActivityId:goodsEntity.goodsId goodsId:goodsEntity.activityId];
        };
        return cell;
        
    } cellDidSelectHandler:^(FMCategoryGoodsModel *goodsEntity) {
        DLog(@"goodsEntity == %@\n砍价商品详情", goodsEntity);
        FMGoodsDetailsController *nextVC = FMGoodsDetailsController.cvc_controller();
        nextVC.goodsId = goodsEntity.goodsId;
        weakSelf.cvc_pushViewController(nextVC);
    }];
    
    _pagingView = pagingView;
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
