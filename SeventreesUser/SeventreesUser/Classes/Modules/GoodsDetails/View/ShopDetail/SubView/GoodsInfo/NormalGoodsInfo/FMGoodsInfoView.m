//
//  FMGoodsInfoView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsInfoView.h"

const CGFloat FMGoodsInfoViewHeight = 110.f;

@interface FMGoodsInfoView ()

@property (nonatomic, weak) IBOutlet UILabel *goodsNameLabel;

@property (nonatomic, weak) IBOutlet UILabel *goodsPriceLabel;

@property (nonatomic, weak) IBOutlet UILabel *soldTotalLabel;

@end

@implementation FMGoodsInfoView

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    self.cv_addTouchEventCallback(^(UIView *view) {
        view.cv_endEditing();
    });
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [RACObserve(self, detailsModel) subscribeNext:^(id x) {
        @strongify(self)
        self->_goodsNameLabel.text = self->_detailsModel.goodsName ?: @"--";
        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", self->_detailsModel.price.floatValue];
        self->_soldTotalLabel.text = [NSString stringWithFormat:@"已售：%@件", self->_detailsModel.virtualSales];
    }];
    
}

#pragma mark - System Functions

- (void)updateConstraints {
    [super updateConstraints];
}

@end
