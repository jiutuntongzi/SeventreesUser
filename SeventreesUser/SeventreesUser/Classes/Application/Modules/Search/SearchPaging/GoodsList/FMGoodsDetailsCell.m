//
//  FMGoodsDetailsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsCell.h"
#import "ChainKit.h"

@interface FMGoodsDetailsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@end

@implementation FMGoodsDetailsCell

- (void)fm_setupSubviews {
    self.ctc_selectedColor(nil);
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMCategoryGoodsModel *goodsEntity) {
        @strongify(self)
        
        [self->_goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.imgUrl]];
        self->_goodsNameLabel.text = goodsEntity.name ?: @"--";
        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", goodsEntity.retailPrice.floatValue];
    }];
}

@end
