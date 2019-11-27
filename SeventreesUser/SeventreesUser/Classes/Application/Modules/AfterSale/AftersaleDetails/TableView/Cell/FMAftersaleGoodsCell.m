//
//  FMAftersaleGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAftersaleGoodsCell.h"

@interface FMAftersaleGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation FMAftersaleGoodsCell

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMRefundGoodsModel *goodsEntity) {
        @strongify(self)    if (! self) return;
        
        [self->_imgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.goodsImage]];
        self->_titleLabel.text = goodsEntity.goodsName ?: @"--";
        self->_totalLabel.text = [NSString stringWithFormat:@"x%@", goodsEntity.goodsNum];
    }];
}

@end
