//
//  FMSlashGoodsView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashGoodsView.h"

@interface FMSlashGoodsView ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@end

@implementation FMSlashGoodsView

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMSlashInGoodsModel *goodsEntity) {
        @strongify(self)    if (!self) return;
        // 您正在发起砍价
        //    砍价失败 icon_slashFailure
        //    您已完成砍价 icon_slashSuccess
//        self->_statusLabel.text = @"";
//        self->_statusImgView.image = UIImage.ci_imageNamed(@"");
        
        [self->_goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.imgUrl]];
        self->_goodsTitleLabel.text = goodsEntity.name;
        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"原价：¥%.2f", goodsEntity.normalPrice.floatValue];
//        self->_remainingTimeLabel.text = [NSString stringWithFormat:@"剩余 %@", goodsEntity.];
    }];
}

@end
