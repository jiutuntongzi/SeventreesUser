//
//  FMGoodsFooterView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsFooterView.h"

const CGFloat FMGoodsFooterViewHeight = 158.f;

@interface FMGoodsFooterView ()

@property (nonatomic, weak) IBOutlet UILabel *goodsMoneyLabel;
@property (nonatomic, weak) IBOutlet UILabel *expressAmountLabel;
@property (nonatomic, weak) IBOutlet UILabel *knockMoneyLabel;
@property (nonatomic, weak) IBOutlet UILabel *couponMoneyLabel;
@property (nonatomic, weak) IBOutlet UILabel *integralMoneyLabel;

@property (nonatomic, weak) IBOutlet UILabel *totalPriceLabel;

@end

@implementation FMGoodsFooterView

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, orderPriceEntity) subscribeNext:^(FMOrderPriceModel *orderPriceEntity) {
        @strongify(self)
        
        self->_goodsMoneyLabel.text = [NSString stringWithFormat:@"￥%@", orderPriceEntity.goodsMoney];
        self->_expressAmountLabel.text = [NSString stringWithFormat:@"￥%@", orderPriceEntity.expressAmount];
        self->_knockMoneyLabel.text = [NSString stringWithFormat:@"-￥%@", orderPriceEntity.knockMoney];
        self->_couponMoneyLabel.text = [NSString stringWithFormat:@"-￥%@", orderPriceEntity.couponMoney];
        self->_integralMoneyLabel.text = [NSString stringWithFormat:@"-￥%@", orderPriceEntity.integralMoney];
        
        self->_totalPriceLabel.text = [NSString stringWithFormat:@"￥%@", orderPriceEntity.totalPrice];
    }];
}

@end
