//
//  FMShopDetailView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShopDetailView.h"

#import "FMGoodsPictureView.h"
#import "FMGoodsInfoView.h"

const CGFloat FMShopDetailViewHeight = 400.f + 110.f;

@interface FMShopDetailView ()

@property (nonatomic, strong) FMGoodsPictureView *goodsPictureView;

@property (nonatomic, strong) FMGoodsInfoView *goodsInfoView;

@end

@implementation FMShopDetailView

- (void)fm_setupSubviews {
    [self setupGoodsPictureView];
    
    [self setupGoodsInfoView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

/** 商品图片浏览器 */
- (void)setupGoodsPictureView {
    _goodsPictureView = [[FMGoodsPictureView alloc] init];
    _goodsPictureView.backgroundColor = UIColor.whiteColor;
    self.cv_addSubview(_goodsPictureView);
}

/** 店铺信息 */
- (void)setupGoodsInfoView {
    _goodsInfoView = (FMGoodsInfoView *)FMGoodsInfoView.cv_viewFromNibLoad();
    self.cv_addSubview(_goodsInfoView);
}

#pragma mark - System Functions

- (void)updateConstraints {
    [super updateConstraints];
    
    [_goodsPictureView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(FMGoodsPictureViewHeight);
    }];
    
    [_goodsInfoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(FMGoodsPictureViewHeight);
        make.left.right.equalTo(self);
        make.height.equalTo(FMGoodsInfoViewHeight);
    }];
}

@end
