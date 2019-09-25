//
//  FMTagItemCell.m
//  TheWaistcoat
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTagItemCell.h"
#import "ChainKit.h"

@interface FMTagItemCell ()

@property (nonatomic, assign) BOOL isSelected;

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@end

@implementation FMTagItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _itemLabel.layer.cornerRadius = 5.f;
    _itemLabel.layer.borderColor = UIColor.cc_colorByHexString(@"#E5E5E5").CGColor;
    _itemLabel.layer.borderWidth = 1.f;
    _itemLabel.clipsToBounds = YES;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (isSelected) {
        _itemLabel.cv_backColorByHexString(@"#F76F6F");
        _itemLabel.cl_textColor(UIColor.whiteColor);
    } else {
        _itemLabel.cv_backColor(UIColor.whiteColor);
        _itemLabel.cl_textColor(UIColor.cc_colorByHexString(@"#333333"));
    }
}

- (void)setInfo:(NSDictionary *)info {
    _info = [info copy];
    
    _itemLabel.text = info[@"name"] ?: @"无";
    
    NSNumber *isSelectedNumber = _info[@"isSelected"];
    self.isSelected = isSelectedNumber.boolValue;
}

@end
