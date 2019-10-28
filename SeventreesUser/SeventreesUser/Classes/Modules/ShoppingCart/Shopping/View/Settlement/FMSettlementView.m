//
//  FMSettlementView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettlementView.h"

@interface FMSettlementView ()

/** 合计：￥0 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

/** 选中所有 */
@property (nonatomic, weak) IBOutlet UIButton *checkAllButton;

/** 结算/删除按编辑状态2选1 */
@property (nonatomic, weak) IBOutlet UIButton *settleCarButton;

/** 结算/删除按编辑状态2选1 */
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;

@end

@implementation FMSettlementView

- (void)fm_setupSubviews {
    
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [RACObserve(self, viewModel.isEdit) subscribeNext:^(NSNumber *isEdit) {
        @strongify(self)    if (!self) return;
        self->_settleCarButton.hidden = isEdit.boolValue;
        self->_totalPriceLabel.hidden = isEdit.boolValue;
        
        self->_deleteButton.hidden = !isEdit.boolValue;
    }];
    
    [RACObserve(self, viewModel.totalPrice) subscribeNext:^(NSNumber *totalPrice) {
        @strongify(self)    if (!self) return;
        self->_totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f", totalPrice.floatValue];
    }];
    
    [RACObserve(self, viewModel.checkedGoodsTotal) subscribeNext:^(NSNumber *checkedGoodsTotal) {
        @strongify(self)    if (!self) return;
        NSString *totalTitle = [NSString stringWithFormat:@"结算(%@)", checkedGoodsTotal];
        self->_settleCarButton.cb_title(totalTitle);
    }];
    
    [RACObserve(self, viewModel.isCheckedAll) subscribeNext:^(NSNumber *isCheckedAll) {
        @strongify(self)    if (!self) return;
        NSString *imageName;
        if (isCheckedAll.boolValue) {
            imageName = @"icon_check_selected";
        } else {
            imageName = @"icon_check_normal";
        }
        self->_checkAllButton.cb_setImageOfNamed(imageName);
    }];
    
    [[_checkAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        @strongify(self)    if (!self) return;
        
        BOOL isCheckedAll = self.viewModel.isCheckedAll;
        isCheckedAll = !isCheckedAll;
        [self.viewModel.checkAllActionSubject sendNext:@(isCheckedAll)];
    }];
    
    [[_settleCarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        @strongify(self)    if (!self) return;
        [self.viewModel.settleActionSubject sendNext:nil];
    }];
    
    [[_deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        @strongify(self)    if (!self) return;
        [self.viewModel.deleteActionSubject sendNext:nil];
    }];
}

- (FMSettlementViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMSettlementViewModel alloc] init];
    }
    return _viewModel;
}

@end
