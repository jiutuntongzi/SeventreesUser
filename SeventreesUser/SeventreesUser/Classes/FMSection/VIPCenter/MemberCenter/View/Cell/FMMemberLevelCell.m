//
//  FMMemberLevelCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMemberLevelCell.h"
#import "FMMemberLevelModel.h"

@interface FMMemberLevelCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitle1;
@property (weak, nonatomic) IBOutlet UILabel *subTitle2;
@property (weak, nonatomic) IBOutlet UILabel *subTitle3;

@end

@implementation FMMemberLevelCell

- (void)setModel:(FMMemberLevelModel *)model {
    _model = model;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.ctc_selectedColor(nil);
}

@end
