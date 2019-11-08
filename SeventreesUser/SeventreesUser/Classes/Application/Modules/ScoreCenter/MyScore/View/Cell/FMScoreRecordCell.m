//
//  FMScoreRecordCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreRecordCell.h"
#import "FMScoreRecordModel.h"

@interface FMScoreRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation FMScoreRecordCell

- (void)setScoreEntity:(FMScoreRecordModel *)scoreEntity {
    _scoreEntity = scoreEntity;
    
    _titleLabel.text = scoreEntity.title;
    _timeLabel.text = scoreEntity.subTitle;
    
    NSString *symbol = scoreEntity.expendType.integerValue == 2 ? @"-" : @"+";
    _scoreLabel.text = [NSString stringWithFormat:@"%@%@", symbol, scoreEntity.expendIntegral];
    
    NSString *colorHexStr = scoreEntity.expendType.integerValue == 2 ? @"#F76F6F" : @"#7EC52E";
    _scoreLabel.textColor = UIColor.cc_colorByHexString(colorHexStr);;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.ctc_selectedColor(nil);
}

@end
