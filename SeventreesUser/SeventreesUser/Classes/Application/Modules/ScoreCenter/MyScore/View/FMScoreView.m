//
//  FMScoreView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreView.h"

#import "FMScoreHeaderView.h"
#import "FMScoreRecordCell.h"
#import "FMScoreRecordModel.h"

@interface FMScoreView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FMScoreHeaderView *scoreHeaderView;

@end

@implementation FMScoreView

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    [self setupTableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupTableView {
    self.cv_backColor(UIColor.whiteColor);
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    UITableView *tableView = UITableView.ct_tableViewWithFrameStyle(0.f, 0.f, width, height, UITableViewStyleGrouped)\
    .ct_dataSource(self).ct_delegate(self)\
    .ct_rowHeight(FMScoreRecordCellRowHeight).ct_separatorStyle(UITableViewCellSeparatorStyleNone);
    tableView.cv_backColorByHexString(@"#F7F7F7");
    self->_tableView = tableView;
    
    [self addSubview:tableView];
}

- (void)fm_bindObserver {
    /// RAC-KVO
    /*
    @weakify(self)
    [RACObserve(self.viewModel, scoreEntitys) subscribeNext:^(NSArray *scoreEntitys) {
        @strongify(self)
        [self->_tableView reloadData];
    }];
    */
    
//    @weakify(self)
//    [[self.viewModel rac_valuesForKeyPath:@"scoreEntitys" observer:nil] subscribeNext:^(NSArray * _Nullable scoreEntitys) {
//        @strongify(self)
//        DLog(@"%@", scoreEntitys);
//    }];
    
//    @weakify(self)
//    [[self.viewModel rac_valuesAndChangesForKeyPath:@"scoreEntitys" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld observer:nil] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self)
//        NSArray * _Nullable scoreEntitys = tuple.first;
//
//    }];
    
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    // 绑定头部ViewModel
    [self.viewModel.refreshUISubject subscribeNext:^(id x) {
        @strongify(self)
        [self.scoreHeaderView.viewModel.requestDataCommand execute:nil];
    }];
    
    [self.scoreHeaderView.viewModel.nextPageSubject subscribeNext:^(NSString *webExplainURL) {
        @strongify(self)
        [self.viewModel.nextPageSubject sendNext:webExplainURL];
    }];
    
    
    // 绑定表格ViewModel
    [self.viewModel.refreshRecordSubject subscribeNext:^(id x) {
        @strongify(self)
        [self->_tableView reloadData];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self); // make.left.right.top.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMScoreViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMScoreViewModel alloc] init];
    }
    return _viewModel;
}

- (FMScoreHeaderView *)scoreHeaderView {
    if (! _scoreHeaderView) {
        _scoreHeaderView = FMScoreHeaderView.cv_viewFromNibLoad();
        _scoreHeaderView.frame = CGRectZero;
    }
    return _scoreHeaderView;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMScoreRecordCell *cell = FMScoreRecordCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.scoreEntity = self.viewModel.scoreEntitys[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.scoreEntitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"点了第%ld行", (long)indexPath.row);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.scoreHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMScoreHeaderViewHeight;
}

//设置标题  可以根据section的值来设置 第一个为0
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"积分收支明细";
}

@end
