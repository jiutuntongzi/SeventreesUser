//
//  FMShopDetailView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShopDetailView.h"

#import "FMGoodsPictureView.h"

// 2选1
#import "FMGoodsInfoView.h"
#import "FMSpellGoodsInfoView.h"

const CGFloat FMShopDetailViewHeight = 400.f + 110.f;

const CGFloat FMSpellShopDetailViewHeight = 400.f + 150.f;

@interface FMShopDetailView ()

@property (nonatomic, strong) FMGoodsPictureView *goodsPictureView;

@property (nonatomic, strong) UIView *goodsInfoView;

@end

@implementation FMShopDetailView

- (void)fm_setupSubviews {
    [self setupGoodsPictureView];
    
    [self setupGoodsInfoView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

/** 商品图片浏览 */
- (void)setupGoodsPictureView {
    _goodsPictureView = [[FMGoodsPictureView alloc] init];
    _goodsPictureView.backgroundColor = UIColor.whiteColor;
    self.cv_addSubview(_goodsPictureView);
}

/** 商品详情信息 */
- (void)setupGoodsInfoView {
    if (global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleSpell) {
        FMSpellGoodsInfoView *spellGoodsInfoView = FMSpellGoodsInfoView.cv_viewFromNibLoad();
        _goodsInfoView = spellGoodsInfoView;
        [self addSubview:spellGoodsInfoView];
    } else {
        FMGoodsInfoView *normalGoodsInfoView = FMGoodsInfoView.cv_viewFromNibLoad();
        _goodsInfoView = normalGoodsInfoView;
        [self addSubview:normalGoodsInfoView];
    }
}

#pragma mark - System Functions

- (void)updateConstraints {
    [super updateConstraints];
    
    [_goodsPictureView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(FMGoodsPictureViewHeight);
    }];
    
    CGFloat height = FMGoodsInfoViewHeight;
    if (global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleSpell) {
        height = FMSpellGoodsInfoViewHeight;
    }
    [_goodsInfoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(FMGoodsPictureViewHeight);
        make.left.right.equalTo(self);
        make.height.equalTo(height);
    }];
}

@end
