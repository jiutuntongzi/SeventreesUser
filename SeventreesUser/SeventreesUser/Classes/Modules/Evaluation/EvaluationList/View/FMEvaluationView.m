
//
//  FMEvaluationView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMEvaluationView.h"
#import "FMEvaluationViewModel.h"
#import "FMEvaluationCell.h"

@interface FMEvaluationView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FMEvaluationViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMEvaluationView

#pragma mark - System Functions

- (void)updateConstraints {
    
    CGFloat settlementHeight = 50.f;
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];

    [super updateConstraints];
}


#pragma mark - Private Functions

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f));
    
    self.setupTableView();
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void (^)(void))setupTableView {
    return ^{
        UITableView *tableView = UITableView.ct_tableView();
        self->_tableView = tableView;
        tableView.ct_dataSource(self).ct_delegate(self)\
        .ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))\
        .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
        .cv_backColor(UIColor.clearColor);
        tableView.cs_showsHorizontalScrollIndicator(NO).cs_showsVerticalScrollIndicator(NO);
        tableView.estimatedRowHeight = YES;
        
        self.cv_addSubview(tableView);
    };
}

- (void)fm_bindViewModel {
    
}

- (void)refreshUI {
    
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMEvaluationCell *cell = FMEvaluationCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.ctc_selectedColor(nil); // 默认点暗色
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark ——— <UITableViewDelegate>

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([FMEvaluationCell class]) cacheByIndexPath:indexPath configuration:^(FMEvaluationCell *cell) {
        
    }];
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.ct_deselectRowAtIndexPathAnimated(indexPath, YES);
    UIViewController *nextVC = [[NSClassFromString(@"FMBrandGoodsController") alloc] init];
    self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    
    NSLog(@"indexPath.section == %ld indexPath.row == %ld", indexPath.section, indexPath.row);
}

#pragma mark - Lazyload

- (FMEvaluationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMEvaluationViewModel alloc] init];
    }
    return _viewModel;
}

@end
