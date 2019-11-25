//
//  FMSlashRecordCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashRecordCell.h"

@interface FMSlashRecordCell ()

@property (nonatomic, weak) IBOutlet UIImageView *headImgView;

@property (nonatomic, weak) IBOutlet UILabel *nicknameLabel;

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end

@implementation FMSlashRecordCell

- (void)fm_setupSubviews {
    _headImgView.layer.cornerRadius = _headImgView.width * 0.5f;
    _headImgView.clipsToBounds = YES;
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, joinUserEntity) subscribeNext:^(FMBargainUserModel *joinUserEntity) {
        @strongify(self)
        [self->_headImgView sd_setImageWithURL:[NSURL URLWithString:joinUserEntity.headUrl] placeholderImage:UIImage.ci_imageNamed(@"icon_joinUser_placeholder")];
        self->_nicknameLabel.text = joinUserEntity.userName ?: @"--";
        self->_timeLabel.text = joinUserEntity.time ?: @"--";
        self->_priceLabel.text = [NSString stringWithFormat:@"砍掉%.2f元", joinUserEntity.price];
    }];
}

@end
