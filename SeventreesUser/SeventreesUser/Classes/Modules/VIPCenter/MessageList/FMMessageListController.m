//
//  FMMessageListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMessageListController.h"

#import "PagingView.h"
#import "FMMessageCell.h"

@interface FMMessageListController ()

@property (nonatomic, strong) PagingView *pagingListView;


@end

@implementation FMMessageListController

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
    PagingView *pagingView = [[PagingView alloc] initWithLimit:10 uriPath:@"" rowHeight:0.f params:@{@"userId": @"1059"} requestDataHandler:^(NSDictionary *result) {
        //        NSArray *dictArray = [result[@"list"] copy];
        //        NSArray *resultEntitys = [[FMStoredRecord mj_objectArrayWithKeyValuesArray:dictArray] copy];
        //        return resultEntitys;
        return @[@{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}];
        
    } cellConfig:^UITableViewCell* (UITableView *tableView, NSIndexPath *indexPath, NSArray *entitys) {
        FMMessageCell *cell = FMMessageCell.ctc_cellReuseNibLoadForTableView(tableView);
//        cell.model = FMMessageModel
        //        cell.storedRecord = [entitys objectCheckAtIndex:indexPath.row];
        return cell;
        
    } cellDidSelectHandler:^(id rowEntity) {
        DLog(@"rowEntity == %@", rowEntity);
    }];

//    pagingView.cv_frame(self.view.bounds);
    pagingView.cv_frame(CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height - kNavBarHeight));
    pagingView.cv_backColorByHexString(@"#EEEEEE");
    _pagingListView = pagingView;
    self.view.cv_addSubview(pagingView);
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"消息中心";
    
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"清空消息", 1, ^(UIBarButtonItem *rightItem) {
        
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
