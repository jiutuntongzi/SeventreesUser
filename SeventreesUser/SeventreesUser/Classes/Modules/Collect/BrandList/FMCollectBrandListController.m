//
//  FMCollectBrandListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectBrandListController.h"
#import "FMCollectBrandCell.h"

@interface FMCollectBrandListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMCollectBrandListController

- (void)fm_addSubviews {
    self.view.bounds = CGRectMake(0, 0, self.view.width, kScreenHeight - kStatusBarHeight - kFixedHeight - 40.f);
    
    UIColor *backColor = UIColor.cc_colorByHexString(@"#F7F7F7");
    self.view.cv_backColor(backColor);
    
    void (^setTableViewBlock)(void) = ^{
        UITableView *tableView = UITableView.ct_tableView();
        self->_tableView = tableView;
        tableView.ct_dataSource(self).ct_delegate(self)\
        .ct_rowHeight(FMCollectBrandCellHeight).ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))\
        .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
        .cv_backColor(backColor);
        tableView.cs_showsVerticalScrollIndicator(NO);
        self.view.cv_addSubview(tableView);
    };
    setTableViewBlock(); // 生成表格
}

- (void)fm_makeConstraints {
    _tableView.frame = self.view.bounds;
    
//    [_tableView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
////        make.left.right.top.equalTo(self.view);
////        make.bottom.equalTo(self.view).offset(- kNavBarHeight - kTabBarHeight - kFixedHeight);
//    }];
}

- (void)fm_bindViewModel {
    self.view.cv_addTouchEventCallback(^(UIView *view) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    });
    
    @weakify(self)
    [[self.viewModel rac_valuesAndChangesForKeyPath:@"searchText" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
//        NSString *searchText = tuple.first; // newValue
//        if (! searchText) {
//            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//            [SVProgressHUD showInfoWithStatus:@"输入不能为空"];
//            return;
//        }
        [self.viewModel.requestDataCommand execute:nil];
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        [SVProgressHUD showInfoWithStatus:resultModel.jsonString]; // test
        if (! [resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showInfoWithStatus:resultModel.statusMsg];
        }
        [self->_tableView reloadData];
    }];
    
    [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            [SVProgressHUD showWithStatus:@"搜索中.."];
        } else {
            [SVProgressHUD dismissWithDelay:0.5f];
        }
    }];
}

- (void)fm_refreshData {
    
}

- (FMCollectBrandListViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMCollectBrandListViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMCollectBrandCell *cell = FMCollectBrandCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.brandModel = self.viewModel.brandEntitys[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.brandEntitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    
//    FMGoodsDetailsController *nextVC = [[FMGoodsDetailsController alloc] init];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.viewController.navigationController pushViewController:nextVC animated:YES];
//
    NSLog(@"indexPath.section == %ld indexPath.row == %ld \n brandEntity == %@", indexPath.section, indexPath.row, self.viewModel.brandEntitys[indexPath.row]);
}

@end
