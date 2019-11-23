//
//  FMBargainGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainGoodsCell.h"

@interface FMBargainGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (weak, nonatomic) IBOutlet UILabel *residueCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *goBargainButton;

@end

@implementation FMBargainGoodsCell

- (void)fm_setupSubviews {
    self.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMCategoryGoodsModel *goodsEntity) {
        @strongify(self)
        
        [self->_goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.imgUrl]];
        self->_residueCountLabel.text = [NSString stringWithFormat:@"剩余%@件", goodsEntity.num];
        self->_goodsNameLabel.text = goodsEntity.name ?: @"--";
        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", goodsEntity.retailPrice.floatValue];
        self->_originalPriceLabel.text = [NSString stringWithFormat:@"原价：￥%.2f", goodsEntity.normalPrice.floatValue];
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [[_goBargainButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        if (self->_goBargainActionCallback) self->_goBargainActionCallback(self->_goodsEntity);
    }];
}

@end
