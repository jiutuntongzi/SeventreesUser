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
    __weak typeof(self) weakSelf = self;
    
    // FMOrderCellRowHeight 动态组高
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:kFindNameLikeURIPath rowHeight:FMGoodsDetailsCellRowHeight params:@{@"name": @"衣服"} requestDataHandler:^(NetworkResultModel *resultModel) {
//        NSArray *dictArray = [result[@"list"] copy];
//        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
//        return resultEntitys;
        return @[@{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMGoodsDetailsCell *cell = FMGoodsDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
        //        cell.viewModel.orderListModel
        //        cell.storedRecord = [entitys objectCheckAtIndex:indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
//        FMOrderDetailsController *nextVC = [[FMOrderDetailsController alloc] init];
//        nextVC.type = FMOrderDetailsPageStyleWaitPay;
//        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 40.f));
    _pagingView = pagingView;
    self.view.cv_addSubview(pagingView);
}

- (void)fm_makeConstraints {
    
}

- (void)fm_bindViewModel {
    self.view.cv_addTouchEventCallback(^(UIView *view) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    });
    
    @weakify(self)
    [[self rac_valuesAndChangesForKeyPath:@"searchText" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        NSString *searchText = tuple.first; // newValue
        if (! searchText.length) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            [SVProgressHUD showInfoWithStatus:@"输入不能为空"];
            return;
        }
        [self->_pagingView requestData];
    }];
    
//    [RACObserve(self, searchText) subscribeNext:^(NSString *searchText) {
            // ..
//    }];
}

- (void)fm_setupNavbar {
    
}

- (void)fm_refreshData {
    
}

@end
