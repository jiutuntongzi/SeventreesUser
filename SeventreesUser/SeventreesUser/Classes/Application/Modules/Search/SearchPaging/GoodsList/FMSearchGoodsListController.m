//
//  FMSearchGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSearchGoodsListController.h"
#import "PagingView.h"
#import "FMGoodsDetailsCell.h"

@interface FMSearchGoodsListController ()

@property (nonatomic, strong) PagingView *pagingView;

@end

@implementation FMSearchGoodsListController

- (void)fm_addSubviews {
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:kHomeQueryBrandGoodsURIPath rowHeight:FMGoodsDetailsCellRowHeight params:nil requestDataHandler:^(NetworkResultModel *resultModel) {
        [SVProgressHUD dismissWithDelay:0.5f];
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
        }
        [SVProgressHUD showInfoWithStatus:resultModel.jsonString]; // test
        
        NSArray *goodsEntitys = [[FMGoodsDetailsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"goodsModels"]] copy];
        return goodsEntitys;
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMGoodsDetailsCell *cell = FMGoodsDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
        cell.viewModel.goodsModel = entitys[indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(FMGoodsDetailsModel *goodsEntity) {
        DLog(@"goodsEntity == %@", goodsEntity);
//        FMOrderDetailsController *nextVC = [[FMOrderDetailsController alloc] init];
//        nextVC.type = FMOrderDetailsPageStyleWaitPay;
//        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    _pagingView = pagingView;
    self.view.cv_addSubview(pagingView);
}

- (void)fm_makeConstraints {
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
    //    CGRect bounds = self.view.bounds;
    _pagingView.cv_frame(self.view.bounds);
}

- (void)fm_bindViewModel {
    self.view.cv_addTouchEventCallback(^(UIView *view) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    });
    
    @weakify(self)
    [[self rac_valuesAndChangesForKeyPath:@"searchText" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
//        NSString *searchText = tuple.first; // newValue
//        if (! searchText) {
//            [SVProgressHUD showInfoWithStatus:@"输入不能为空"];
//            return;
//        }
        [SVProgressHUD showWithStatus:@"搜索中.."];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:7];
        params[@"goodsName"] = self->_searchText ?: @"";
        params[@"categoryId"] = @(1);
        params[@"activityType"] = @(1);
        params[@"sidx"] = @(1);
        params[@"order"] = @(1); // 排列顺序（1 = 正序 2 = 逆序）
        [self->_pagingView requestDataByParams:params];
    }];
//    [RACObserve(self, searchText) subscribeNext:^(NSString *searchText) {
            // ..
//    }];
}

- (void)fm_refreshData {
    
}

@end
