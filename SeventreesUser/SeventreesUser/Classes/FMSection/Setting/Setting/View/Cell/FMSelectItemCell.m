//
//  FMSelectItemCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSelectItemCell.h"
#import "FMSelectItemModel.h"

@interface FMSelectItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation FMSelectItemCell

- (void)setItemModel:(FMSelectItemModel *)itemModel {
    _itemModel = itemModel;
    
    _titleLabel.text = itemModel.title;
    _subTitleLabel.text = itemModel.subTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 右箭头
    self.ctc_selectedColor(nil);
}

@end
