//
//  FMGoodsView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsView.h"
#import "FMGoodsSectionCell.h"

@interface FMGoodsView () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMGoodsView

- (void)fm_setupSubviews {
    /*
    CGFloat (^rowHeightBlock)(void) = ^{
        CGFloat rlMargin = 12.f, lrMargin = 15.f, topMargin = 55.f;
        CGFloat itemWidth = (kScreenWidth - lrMargin * 2.f - rlMargin) * 0.5;
        CGFloat itemHeight = itemWidth * 1.42f;
        CGFloat rowHeight = itemHeight * 2.f + rlMargin + topMargin;
        return rowHeight;
    };
    */
    _tableView.rowHeight = glo_rowHeight();
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [RACObserve(self.viewModel, goodsGroupModels) subscribeNext:^(id x) {
        @strongify(self)    if (! self) return;
        [self->_tableView reloadData];
        GCDDispatchMgr.afterByIntervalForCallback(0.1f, ^{
            [self->_tableView scrollToTop]; // 修复，刷新Cell时跑出屏幕外不见了
        });
    }];
    
//    [[self.viewModel rac_valuesAndChangesForKeyPath:@"goodsGroupModels" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self)
//        [self->_tableView reloadData];
//    }];
}

- (FMGoodsViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMGoodsViewModel alloc] init];
    }
    return _viewModel;
}


inline static CGFloat glo_rowHeight() {
    CGFloat rlMargin = 12.f, lrMargin = 15.f, topMargin = 55.f;
    CGFloat itemWidth = (kScreenWidth - lrMargin * 2.f - rlMargin) * 0.5;
    CGFloat itemHeight = itemWidth * 1.42f;
    return itemHeight * 2.f + rlMargin + topMargin;
}


#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMGoodsSectionCell *cell = FMGoodsSectionCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.groupModel = self.viewModel.goodsGroupModels[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.goodsGroupModels.count;
}

@end
