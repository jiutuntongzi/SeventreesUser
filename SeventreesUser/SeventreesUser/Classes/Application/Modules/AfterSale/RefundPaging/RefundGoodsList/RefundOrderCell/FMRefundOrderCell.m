//
//  FMRefundOrderCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundOrderCell.h"
#import "FMRefundInGoodsCell.h"

@interface FMRefundOrderCell () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 售后状态(0等待处理,1审核不通过,2审核通过（退货中未填写物流）,3审核通过（退款中/退货中已填写物流）,5退款成功,4商家已验收 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *detailsButton;

@end

@implementation FMRefundOrderCell

- (void)fm_setupSubviews {
    self.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
    
    _detailsButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _detailsButton.layer.cornerRadius = 15.f;
    _detailsButton.layer.borderWidth = 1.f;
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, refundEntity) subscribeNext:^(FMRefundOrderModel *refundEntity) {
        @strongify(self)    if (! self) return;
        
        NSString *statusText = nil;
        if (refundEntity.status == nil) statusText = @"--";
        
        if (refundEntity.status.integerValue == 1) {
            
        } else if (refundEntity.status.integerValue == 2) {
            
        } else if (refundEntity.status.integerValue == 3) {
            
        } else if (refundEntity.status.integerValue == 4) {
            
        } else { // refundEntity.status == 0
            
        }
        self->_statusLabel.text = statusText;
        [self->_tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self->_refundEntity.goodsEntitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMRefundInGoodsCell *cell = FMRefundInGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.goodsEntity = self->_refundEntity.goodsEntitys[indexPath.row];
    return cell;
}

@end
