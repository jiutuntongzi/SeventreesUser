//
//  FMStoreListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreListController.h"
#import "PagingView.h"
#import "FMStoreCheckCell.h"

#import "DialogBoxView.h"

#import "FMStoreLocationController.h"

@interface FMStoreListController ()

@property (nonatomic, strong) PagingView *pagingListView;

@end

@implementation FMStoreListController

#pragma mark - Private Functions

- (void)fm_addSubviews {
    PagingView *pagingView = [[PagingView alloc] initWithLimit:0 uriPath:kStoreListQueryURIPath rowHeight:0.f params:nil requestDataHandler:^(NetworkResultModel *resultModel) {
        /*
        /// test
        NSDictionary *testDict = @{
                               @"extra": @{},
                               @"id": @(17),   // --门店id
                               @"dr": @"N",
                               @"name": @"孩子屋",    //--门店名字
                               @"phone": @"13515562548",    //--门店电话
                               @"detailedAddress": @"鼓楼大街21号",    //--门店地址
                               @"logoUrl": @"http://shengmei1868.com/erp/20190819/97372da9c3584cfb95dd23b16366be35.png",
                               @"latitude": @"39.92855",    //--门店纬度
                               @"longitude": @"116.41637",    //--门店经度
                               @"storeDistance": @"4.910147348490498"    //--距离
                               };
        NSMutableArray *mStoreEntitys = [NSMutableArray array];
        for (NSUInteger idx = 0; idx != 5; idx++) {
            FMStoreCheckModel *storeEntity = [FMStoreCheckModel mj_objectWithKeyValues:testDict];
            [mStoreEntitys addObject:storeEntity];
        }
        return [mStoreEntitys copy];
        */
        if (![resultModel.statusCode isEqualToString:@"OK"]) [SVProgressHUD showErrorWithStatus:resultModel.statusMsg];
        NSArray *storeEntitys = [FMStoreCheckModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict];
        return [storeEntitys copy];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMStoreCheckCell *cell = FMStoreCheckCell.ctc_cellReuseNibLoadForTableView(tableView);
        
        FMStoreCheckViewModel *viewModel = [[FMStoreCheckViewModel alloc] init];
        FMStoreCheckModel *storeEntity = entitys[indexPath.row];
        storeEntity.indexPath = indexPath;
        viewModel.storeEntity = storeEntity;
        cell.viewModel = viewModel;
        
        __weak typeof(self) weakSelf = self;
        [cell.viewModel.checkActionSubject subscribeNext:^(FMStoreCheckModel *storeEntity) {
            DLog(@"选中门店 storeEntity == %@", storeEntity);
            NSString *message = @"因门店间会员信息不共享，修改门店将导致您所拥有的积分、优惠券、会员等级全部清空。\n您确定要换绑新门店吗？";
            [DialogBoxView showByTitle:@"换绑门店" message:message affirmButtonTitle:@"确定" forStyle:DialogBoxViewStyleAffirm affirmHandler:^(NSString * _Nullable text) {
                // code... 请求成功后选中Cell
                [weakSelf requestUpdateBindStoreByStoreId:storeEntity.storeId completed:^(BOOL isSuccess) {
                    if (isSuccess) {
                        FMStoreCheckCell *checkCell = [tableView cellForRowAtIndexPath:storeEntity.indexPath];
                        [checkCell selectCurrentCell];
                    }
                }];
            }];
        }];
        
        [cell.viewModel.telephoneActionSubject subscribeNext:^(FMStoreCheckModel *storeEntity) {
            DLog(@"点了电话 storeEntity == %@", storeEntity);
        }];
        
        [cell.viewModel.addressActionSubject subscribeNext:^(FMStoreCheckModel *storeEntity) {
            DLog(@"点了地址 storeEntity == %@", storeEntity);
            FMStoreLocationController *nextVC = [[FMStoreLocationController alloc] init];
            [weakSelf.navigationController pushViewController:nextVC animated:YES];
        }];
        return cell;
        
    } cellDidSelectHandler:^(FMStoreCheckModel *storeEntity) {
        DLog(@"storeEntity == %@", storeEntity);
    }];
    _pagingListView = pagingView;
    pagingView.cv_backColorByHexString(@"#EEEEEE");
    self.view.cv_addSubview(pagingView);
}

- (void)fm_makeConstraints {
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
    _pagingListView.cv_frame(self.view.bounds);
    
    // 请求绑定新门店
    [_pagingListView requestDataByParams:@{@"longitude": @"112.993422", @"latitude": @"28.139724"}];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"选择门店";
}

- (void)fm_refreshData {
    //    [_pagingListView requestDataByParams:@{@"longitude": @"112.993422", @"latitude": @"28.139724"}];
}

/** 请求绑定新门店 */
- (void)requestUpdateBindStoreByStoreId:(NSNumber *)storeId completed:(void (^)(BOOL isSuccess))completed {
    [SVProgressHUD showWithStatus:nil];
    [networkMgr POST:kUpdateBindStoreURIPath params:@{@"sid": storeId} success:^(NetworkResultModel *resultModel) {
        [SVProgressHUD dismissWithDelay:1.f];
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            if (completed) completed(NO);
            [SVProgressHUD showErrorWithStatus:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"换绑成功"];
        if (completed) completed(YES);
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

@end
