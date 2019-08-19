//
//  FMTableViewCell.m
//  YXGJSJ
//
//  Created by wushiye on 2019/7/29.
//  Copyright © 2019 印象管家商家. All rights reserved.
//

#import "FMTableViewCell.h"

@implementation FMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self fm_setupSubviews];
    [self fm_bindViewModel];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self fm_setupSubviews];
        [self fm_bindViewModel];
    }
    return self;
}

/** 设置子views */
- (void)fm_setupSubviews { /** Subclass overwrite */ };
/** 绑定ViewModel */
- (void)fm_bindViewModel { /** Subclass overwrite */ };

@end
