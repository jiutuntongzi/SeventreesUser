//
//  FMMemberCenterView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMemberCenterView.h"

#import "FMMemberHeaderView.h"
#import "FMMemberLevelCell.h"
#import "FMMemberLevelModel.h"

@interface FMMemberCenterView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FMMemberHeaderView *memberHeaderView;

@end

@implementation FMMemberCenterView

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    [self setupTableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupTableView {
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    UITableView *tableView = UITableView.ct_tableViewWithFrameStyle(0.f, 0.f, width, height, UITableViewStylePlain)\
    .ct_dataSource(self).ct_delegate(self)\
    .ct_rowHeight(FMMemberLevelCellRowHeight).ct_separatorStyle(UITableViewCellSeparatorStyleNone);
    tableView.cv_backColorByHexString(@"#F7F7F7");
    self->_tableView = tableView;
    
    [self addSubview:tableView];
}

- (void)fm_bindViewModel {
    
    // 绑定头部、尾部Model RAC-KVO
}

#pragma mark - System Functions

- (void)updateConstraints {
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self); // make.left.right.top.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMMemberCenterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMMemberCenterViewModel alloc] init];
    }
    return _viewModel;
}

- (FMMemberHeaderView *)memberHeaderView {
    if (! _memberHeaderView) {
        FMMemberHeaderView *memberHeaderView = (FMMemberHeaderView *)FMMemberHeaderView.cv_viewFromNibLoad();
        memberHeaderView.frame = CGRectZero;
        _memberHeaderView = memberHeaderView;
    }
    return _memberHeaderView;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMMemberLevelCell *cell = FMMemberLevelCell.ctc_cellReuseNibLoadForTableView(tableView);
//    cell.model = FMMemberLevelModel
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"点了第%ld行", (long)indexPath.row);
    if (indexPath.row == 0) {

    } else if (indexPath.row == 1) {

    } else if (indexPath.row == 2) {
        
        
    } else if (indexPath.row == 3) {

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.memberHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FMMemberHeaderViewHeight;
}

//设置标题  可以根据section的值来设置 第一个为0
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"会员进阶";
}

@end
