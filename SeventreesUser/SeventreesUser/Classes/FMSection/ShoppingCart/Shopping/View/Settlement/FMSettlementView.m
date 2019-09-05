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


@property (nonatomic, weak) IBOutlet UIButton *checkAllButton;

@property (nonatomic, weak) IBOutlet UIButton *settleCarButton;

@end

@implementation FMSettlementView

- (void)fm_setupSubviews {
    
}

- (void)fm_bindViewModel {
    [[_checkAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        [self.viewModel.checkAllActionSubject sendNext:nil];
    }];
    
    [[_settleCarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        [self.viewModel.settleActionSubject sendNext:nil];
    }];
}

@end
