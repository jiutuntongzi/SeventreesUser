//
//  FMGoodsInDetailsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsInDetailsCell.h"

@interface FMGoodsInDetailsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end

@implementation FMGoodsInDetailsCell

- (void)fm_setupSubviews {
    self.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMGoodsInDetailModel *goodsEntity) {
        @strongify(self)
        [self->_imgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.goodsImage] placeholderImage:UIImage.ci_imageNamed(@"test80")];
        self->_titleLabel.text = goodsEntity.goodsName;
        self->_priceLabel.text = [NSString stringWithFormat:@"￥%@", goodsEntity.goodsPrice];
        self->_unitLabel.text = [NSString stringWithFormat:@"x%@", goodsEntity.goodsNum];
    }];
}
@end
