//
//  FMGoodsView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsView.h"
#import "FMGoodsSectionCell.h"

@interface FMGoodsView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMGoodsView

- (void)fm_setupSubviews {

}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMGoodsSectionCell *cell = FMGoodsSectionCell.ctc_cellReuseNibLoadForTableView(tableView);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark ——— <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return glo_rowHeight();
}

inline static CGFloat glo_rowHeight() {
    CGFloat rlMargin = 12.f, lrMargin = 15.f, topMargin = 55.f;
    CGFloat itemWidth = (kScreenWidth - lrMargin * 2.f - rlMargin) * 0.5;
    CGFloat itemHeight = itemWidth * 1.42f;
    return itemHeight * 2.f + rlMargin + topMargin;
}

@end
