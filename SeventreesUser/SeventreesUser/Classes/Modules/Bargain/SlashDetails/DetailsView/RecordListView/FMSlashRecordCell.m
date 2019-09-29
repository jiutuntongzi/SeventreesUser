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
    self.ctc_selectedColor(nil);
    _headImgView.layer.cornerRadius = _headImgView.width * 0.5f;
    _headImgView.clipsToBounds = YES;
}

- (void)fm_bindViewModel {
    
}

@end
