//
//  FMAddressInfoCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAddressInfoCell.h"

@interface FMAddressInfoCell ()

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation FMAddressInfoCell

- (void)setModel:(FMAddressInfoModel *)model {
    _model = model;
    
    
}

- (void)fm_setupSubviews {
    @weakify(self)
    [[_editButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        if (self->_editActionBlock) self->_editActionBlock(self->_model);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.ctc_selectedColor(nil);
}

@end
