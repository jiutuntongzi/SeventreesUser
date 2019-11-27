//
//  FMRefundFooterView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundFooterView.h"

#import "FMRefundExplainView.h"
#import "FMOrderContactUsView.h"

#define     kSpaceValue      15.f

CGFloat FMRefundFooterView_height = kSpaceValue + FMRefundExplainViewHeight + FMOrderContactUsViewHeight;

@interface FMRefundFooterView ()

@property (nonatomic, assign) UInt8 style;

@property (nonatomic, strong) FMRefundExplainView *explainView;

@property (nonatomic, strong) FMOrderContactUsView *contactUsView;

@end

@implementation FMRefundFooterView

- (instancetype)initWithStyle:(UInt8)style {
    if (self = [super init]) {
        _style = style;
        
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setExplainEntity:(FMRefundExplainModel *)explainEntity {
    _explainEntity = explainEntity;
    
    _explainView.explainEntity = explainEntity;
}

- (void)setupSubviews {
    
    _explainView = FMRefundExplainView.cv_viewFromNibLoad();
    [self addSubview:_explainView];
    
    _contactUsView = FMOrderContactUsView.cv_viewFromNibLoad();
    [self addSubview:_contactUsView];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    __block CGFloat offsetY = 0.f;
    __block CGFloat explainHeight = FMRefundExplainViewHeight;
    
    offsetY += kSpaceValue;
    [_explainView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(offsetY);
        make.left.equalTo(self);
        make.width.equalTo(self);
        if (self->_style == 1) explainHeight = FMRefundExplainViewMaxHeight;
        make.height.equalTo(explainHeight);
    }];
    
    offsetY += explainHeight;
    [_contactUsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(FMOrderContactUsViewHeight);
    }];
    
    FMRefundFooterView_height = kSpaceValue + explainHeight + FMOrderContactUsViewHeight;
}

@end
