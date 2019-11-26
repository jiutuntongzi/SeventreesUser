//
//  FMRefundInGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundInGoodsCell.h"


@interface FMRefundInGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation FMRefundInGoodsCell

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMRefundGoodsModel *goodsEntity) {
        @strongify(self)    if (! self) return;
        
        [self->_imgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.goodsImage]];
        self->_titleLabel.text = goodsEntity.goodsName ?: @"--";
        self->_totalLabel.text = goodsEntity.goodsNum.stringValue;
    }];
}

@end
