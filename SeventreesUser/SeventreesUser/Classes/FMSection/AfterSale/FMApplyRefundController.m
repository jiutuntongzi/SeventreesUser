//
//  FMApplyRefundController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMApplyRefundController.h"
#import "FMRefundGoodsCell.h"

#define      kContentFixedHeight       380.f

@interface FMApplyRefundController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightCons;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsListHeightCons;

@end

@implementation FMApplyRefundController

- (void)fm_addSubviews {
    _tableView.rowHeight = FMRefundGoodsCellHeight;
    _tableView.dataSource = self;
}

- (void)fm_makeConstraints {
    
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"申请退款/退货";
}

#define     testCount       5.f

- (void)fm_refreshData {
    // test
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_goodsListHeightCons.constant = FMRefundGoodsCellHeight * testCount;
        self->_contentHeightCons.constant = kContentFixedHeight + FMRefundGoodsCellHeight * testCount;
    });

    
}

#pragma mark - <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMRefundGoodsCell *cell = FMRefundGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return testCount;
}

@end
