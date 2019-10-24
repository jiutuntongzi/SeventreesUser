//
//  FMShoppingGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingGoodsCell.h"

@interface FMShoppingGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsSubTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;

@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseButtonWidthConstraint;

@end

@implementation FMShoppingGoodsCell

- (void)fm_setupSubviews {
    self.ctc_selectedColor(nil);
}

- (void)fm_bindViewModel {
    @weakify(self)
    [RACObserve(self, goodsEntity) subscribeNext:^(FMShoppingGoodsModel *goodsEntity) {
        @strongify(self)    if (!self) return;
        
        [self->_goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsEntity.imgURLStr]];
        self->_goodsTitleLabel.text = goodsEntity.goodsName ?: @"--";
        self->_goodsSubTitleLabel.text = goodsEntity.propertiesName ?: @"--";
        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"¥%.2f", goodsEntity.goodsPrice.floatValue];
        self->_goodsCountLabel.text = [NSString stringWithFormat:@"%lu", goodsEntity.goodsNum];
        
        if (goodsEntity.isEdit) {
            self->_chooseButtonWidthConstraint.constant = 50.f;
            self->_chooseButton.hidden = NO;
        } else {
            self->_chooseButtonWidthConstraint.constant = 15.f;
            self->_chooseButton.hidden = YES;
        }
    }];
    
    [RACObserve(self.goodsEntity, goodsNum) subscribeNext:^(NSNumber *goodsNum) {
        @strongify(self)
        self->_goodsCountLabel.text = goodsNum.stringValue;
    }];
    
    [RACObserve(self.goodsEntity, isChecked) subscribeNext:^(NSNumber *isChecked) {
        @strongify(self)
        if (isChecked.boolValue) {
            self->_chooseButton.cb_setImageOfNamed(@"icon_check_selected");
            self->_chooseButton.cb_title(@"1");
            
        } else {
            self->_chooseButton.cb_setImageOfNamed(@"icon_check_normal");
            self->_chooseButton.cb_title(@"0");
        }
    }];
    
    [[_addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        ++ self->_goodsEntity.goodsNum;
    }];
    
    [[_minusButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        -- self->_goodsEntity.goodsNum;
    }];
    
    [[_chooseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *chooseButton) {
        self->_goodsEntity.isChecked = !self->_goodsEntity.isChecked;
    }];
}

@end
