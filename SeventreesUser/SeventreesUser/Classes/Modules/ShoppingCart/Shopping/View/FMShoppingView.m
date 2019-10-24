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
        self->_settlementView = (FMSettlementView *)FMSettlementView.cv_viewFromNibLoad();
        self->_settlementView.viewModel = [[FMSettlementViewModel alloc] init];
        self.cv_addSubview(self->_settlementView);
    };
}

- (void)fm_bindViewModel {
    @weakify(self)
    [self.viewModel.refreshUISubject subscribeNext:^(NSArray<FMShoppingGoodsModel *> *shoppingGoodsEntitys) {
        @strongify(self)    if (!self) return;
        [self->_tableView reloadData];
    }];
    
    [self->_settlementView.viewModel.settleActionSubject subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        [self.viewModel.settleAccountsVCSubject sendNext:nil];
    }];
    
    [RACObserve(self.viewModel, isEdit) subscribeNext:^(NSNumber *isEdit) {
        @strongify(self)    if (!self) return;
        for (FMShoppingGoodsModel *goodsEntity in self.viewModel.shoppingGoodsEntitys) {
            goodsEntity.isEdit = isEdit.boolValue;
        }
        [self->_tableView reloadData];
    }];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMShoppingGoodsCell *cell = FMShoppingGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
//    cell.goodsEntity = self.viewModel.shoppingGoodsEntitys[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
//    return self.viewModel.shoppingGoodsEntitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    NSLog(@"indexPath.section == %ld indexPath.row == %ld", indexPath.section, indexPath.row);
    
//    FMShoppingGoodsModel *goodsModel = self.viewModel.shoppingGoodsEntitys[indexPath.row];
//    [self.viewModel.goodsDetailsVCSubject sendNext:goodsModel.goodsId];
}

#pragma mark - Lazyload

- (FMShoppingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMShoppingViewModel alloc] init];
    }
    return _viewModel;
}

@end
