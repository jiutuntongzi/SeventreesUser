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

#pragma mark - System Functions

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    __weak typeof(self) weakSelf = self;
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:0.f params:@{@"userId": @"1059"} requestDataHandler:^(NSDictionary *result) {
//        NSArray *dictArray = [result[@"list"] copy];
//        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
//        return resultEntitys;
        
        // test
        NSMutableArray *mStoreEntitys = [NSMutableArray array];
        for (NSUInteger idx = 0; idx != 10; idx++) {
            FMStoreCheckModel *storeEntity = [[FMStoreCheckModel alloc] init];
            [mStoreEntitys addObject:storeEntity];
        }
        return [mStoreEntitys copy];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMStoreCheckCell *cell = FMStoreCheckCell.ctc_cellReuseNibLoadForTableView(tableView);
        FMStoreCheckModel *storeEntity = entitys[indexPath.row];
        storeEntity.indexPath = indexPath;
        cell.viewModel.storeEntity = storeEntity;
        
        
        [cell.viewModel.checkActionSubject subscribeNext:^(FMStoreCheckModel *storeEntity) {
            DLog(@"选中门店 storeEntity == %@", storeEntity);
            NSString *message = @"因门店间会员信息不共享，修改门店将导致您所拥有的积分、优惠券、会员等级全部清空。\n您确定要换绑新门店吗？";
            [DialogBoxView showByTitle:@"换绑门店" message:message affirmButtonTitle:@"确定" forStyle:DialogBoxViewStyleAffirm affirmHandler:^(NSString * _Nullable text) {
                // code... 请求成功后选中Cell
                if (YES) {
                    FMStoreCheckCell *checkCell = [tableView cellForRowAtIndexPath:storeEntity.indexPath];
                    [checkCell selectCurrentCell];
                    [SVProgressHUD showSuccessWithStatus:@"换绑成功"];
                }
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
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - 40.f));
    pagingView.cv_backColorByHexString(@"#EEEEEE");
    _pagingListView = pagingView;
    
    self.view.cv_addSubview(pagingView);
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"选择门店";
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
