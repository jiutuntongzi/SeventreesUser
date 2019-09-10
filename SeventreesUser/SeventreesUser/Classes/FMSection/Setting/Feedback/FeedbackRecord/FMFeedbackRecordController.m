//
//  FMFeedbackRecordController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMFeedbackRecordController.h"
#import "PagingView.h"
#import "FMFeedbackRecordCell.h"

@interface FMFeedbackRecordController ()

@property (nonatomic, strong) PagingView *pagingListView;


@end

@implementation FMFeedbackRecordController

#pragma mark - System Functions

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)updateViewConstraints {
//    [_pagingListView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:158.f params:@{@"userId": @"1059"} requestDataHandler:^(NSDictionary *result) {
        //        NSArray *dictArray = [result[@"list"] copy];
        //        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
        //        return resultEntitys;
        return @[@{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMFeedbackRecordCell *cell = FMFeedbackRecordCell.ctc_cellReuseNibLoadForTableView(tableView);
        cell.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
        //        cell.storedRecord = [entitys objectCheckAtIndex:indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
    }];
    // self.view.height - kNavBarHeight - kFixedHeight - 40.f
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.width, self.view.height - kNavBarHeight - kFixedHeight - 20.f));
    _pagingListView = pagingView;
    self.view.cv_addSubview(pagingView);
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"反馈记录";
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
