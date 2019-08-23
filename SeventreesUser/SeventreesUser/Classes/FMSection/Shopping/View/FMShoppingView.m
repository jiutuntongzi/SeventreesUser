//
//  FMShoppingView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingView.h"
#import "FMShoppingViewModel.h"

#import "FMShoppingGoodsCell.h"

#import "FMSettlementView.h"

@interface FMShoppingView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FMShoppingViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FMSettlementView *settlementView;

@end

@implementation FMShoppingView

#pragma mark - System Functions

- (void)updateConstraints {
    
    CGFloat settlementHeight = 50.f;
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(-settlementHeight);
    }];
    
    [_settlementView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(settlementHeight);
    }];
    
    [super updateConstraints];
}


#pragma mark - Private Functions

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f));
    
    self.setupTableView();
    
    self.setupSettlementView();
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void (^)(void))setupTableView {
    return ^{
        UITableView *tableView = UITableView.ct_tableView();
        self->_tableView = tableView;
        tableView.ct_dataSource(self).ct_delegate(self)\
        .ct_rowHeight(120.f).ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))\
        .ct_separatorInset(UIEdgeInsetsZero).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
        .cv_backColor(UIColor.clearColor);
        
        self.cv_addSubview(tableView);
    };
}

- (void (^)(void))setupSettlementView {
    return ^{
        self->_settlementView = FMSettlementView.cv_viewFromNibLoad();
        self.cv_addSubview(self->_settlementView);
    };
}

- (void)fm_bindViewModel {
    
}

- (void)refreshUI {

}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = FMShoppingGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.ctc_selectedColor(nil); // 默认点暗色
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    
    NSLog(@"indexPath.section == %ld indexPath.row == %ld", indexPath.section, indexPath.row);
}

#pragma mark - Lazyload

- (FMShoppingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMShoppingViewModel alloc] init];
    }
    return _viewModel;
}


@end
