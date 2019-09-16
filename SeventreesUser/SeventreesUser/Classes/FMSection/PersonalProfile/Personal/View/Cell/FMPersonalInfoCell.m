//
//  FMPersonalInfoCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPersonalInfoCell.h"
#import "FMPersonalInfoModel.h"

@interface FMPersonalInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation FMPersonalInfoCell

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    _subTitleLabel.cl_textColor(UIColor.cc_colorByHexString(@"#333333"));
}

- (void)setItemModel:(FMPersonalInfoModel *)itemModel {
    _itemModel = itemModel;
    
    _subTitleLabel.cl_textColor(UIColor.cc_colorByHexString(@"#E5E5E5"));
    _titleLabel.text = itemModel.title;
    _subTitleLabel.text = itemModel.subTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 右箭头
    self.ctc_selectedColor(nil);
}

@end
