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
    if (global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleSpell || global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleActivity) {
        
        FMSpellGoodsInfoView *spellGoodsInfoView = (FMSpellGoodsInfoView *)FMSpellGoodsInfoView.cv_viewFromNibLoad();
        _goodsInfoView = spellGoodsInfoView;
        [self addSubview:spellGoodsInfoView];
        
    } else {
        FMGoodsInfoView *normalGoodsInfoView = (FMGoodsInfoView *)FMGoodsInfoView.cv_viewFromNibLoad();
        _goodsInfoView = normalGoodsInfoView;
        [self addSubview:normalGoodsInfoView];
    }
}

- (void)fm_bindViewModel {
    @weakify(self)
    [RACObserve(self, pictureModels) subscribeNext:^(id x) {
        @strongify(self);
        self->_goodsPictureView.pictureModels = self->_pictureModels;
    }];
    
    [RACObserve(self, detailsModel) subscribeNext:^(id x) {
        @strongify(self);
        
        if (global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleSpell || global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleActivity) {
            FMSpellGoodsInfoView *spellGoodsInfoView = (FMSpellGoodsInfoView *)self->_goodsInfoView;
            // code...
            spellGoodsInfoView.detailsModel = self->_detailsModel;
            
        } else {
            FMGoodsInfoView *normalGoodsInfoView = (FMGoodsInfoView *)self->_goodsInfoView;
            normalGoodsInfoView.detailsModel = self->_detailsModel;
        }
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [super updateConstraints];
    
    [_goodsPictureView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(FMGoodsPictureViewHeight);
    }];
    
    CGFloat height = FMGoodsInfoViewHeight;
    if (global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleSpell || global_goodsDetailsPageStyle == FMGoodsDetailsPageStyleActivity) {
        height = FMSpellGoodsInfoViewHeight;
    }
    [_goodsInfoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(FMGoodsPictureViewHeight);
        make.left.right.equalTo(self);
        make.height.equalTo(height);
    }];
}

@end
