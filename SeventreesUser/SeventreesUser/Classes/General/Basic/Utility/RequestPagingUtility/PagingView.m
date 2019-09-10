//
//  PagingView.m
//  YXGJSJ
//
//  Created by wushiye on 2019/8/9.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import "PagingView.h"
#import "ChainKit.h"
//#import "APPRequest.h"
#import "MJRefresh.h"
#import "PagingCalculateUtility.h"

@interface PagingView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PagingCalculateUtility *pagingUtility;

@property (nonatomic, copy) NSArray *entitys;


@property (nonatomic, copy) PVNetworkRequestDataHandler requestDataHandler;

@property (nonatomic, copy) PVTableViewCellConfigHandler cellConfigCallback;

@property (nonatomic, copy) PVTableViewCellDidSelectHandler cellDidSelectHandler;

/** 表格行高 */
@property (nonatomic, assign) CGFloat rowHeight;

/** 分页限制 (默认：limit = 10) */
@property (nonatomic, assign) NSUInteger limit;

/** 统一资源标识(URI)请求路径 */
@property (nonatomic, copy) NSString *uriPath;

/** 请求参数：除limit、page字段外的 */
@property (nonatomic, strong) NSDictionary *params;

@end

@implementation PagingView

- (instancetype)initWithLimit:(NSUInteger)limit uriPath:(NSString *)uriPath rowHeight:(CGFloat)rowHeight params:(NSDictionary *)params requestDataHandler:(PVNetworkRequestDataHandler)requestDataHandler cellConfig:(PVTableViewCellConfigHandler)cellConfig cellDidSelectHandler:(PVTableViewCellDidSelectHandler)cellDidSelectHandler
{
    if (self = [super init]) {
        _limit = limit;
        _uriPath = [uriPath copy];
        _params = params;
        
        _rowHeight = rowHeight;
        
        _requestDataHandler = requestDataHandler;
        _cellConfigCallback = cellConfig;
        _cellDidSelectHandler = cellDidSelectHandler;
        
        [self setupSubviews];
        
        [self requestData];
    }
    return self;
}

- (void)setupSubviews {
    self.setupTableView();
}

- (void (^)(void))setupTableView {
    return ^{
        CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
        UITableView *tableView = UITableView.ct_tableViewWithFrameStyle(0.f, 0.f, width, height, UITableViewStylePlain)\
        .ct_dataSource(self).ct_delegate(self)\
        .ct_rowHeight(self->_rowHeight).ct_separatorStyle(UITableViewCellSeparatorStyleNone).ct_separatorColor(nil)\
        .ct_separatorInset(UIEdgeInsetsZero).ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero));
        self->_tableView = tableView;
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self->_pagingUtility execPullDownRefresh];
        }];
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self->_pagingUtility execUpPullLoad];
        }];
        
        [self addSubview:tableView];
    };
}

- (void)requestData {
    __weak typeof(self) weakSelf = self;
    _pagingUtility = [[PagingCalculateUtility alloc] initWithPageNo:0 limit:_limit uriPath:_uriPath params:_params requestDataHandler:_requestDataHandler finishReloadData:^(NSArray *entitys) {
        weakSelf.entitys = [entitys copy];
        [weakSelf reloadDataForTableView];
    }];
    
    [_pagingUtility execUpPullLoad];
}

- (void)reloadDataForTableView {
    [_tableView reloadData];
    [self->_tableView.mj_header endRefreshing];
    [self->_tableView.mj_footer endRefreshing];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _tableView.frame = self.bounds;
}

#pragma mark ——— <UITableViewDataSource>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = UITableViewCell.ctc_cellReuseForTableView(tableView); // 占位Cell防空
    cell.ctc_selectedColor(nil);
    if (_cellConfigCallback) {
        cell = _cellConfigCallback(tableView, indexPath, _entitys);
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _entitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    
    if (_cellDidSelectHandler) _cellDidSelectHandler(_entitys[indexPath.row]);
    
    NSLog(@"indexPath.section == %ld indexPath.row == %ld", indexPath.section, indexPath.row);
}

@end
