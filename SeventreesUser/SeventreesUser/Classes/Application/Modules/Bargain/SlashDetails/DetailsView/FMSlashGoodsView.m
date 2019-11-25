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
    // 您正在发起砍价
//    砍价失败 icon_slashFailure
//    您已完成砍价 icon_slashSuccess
}

@end
