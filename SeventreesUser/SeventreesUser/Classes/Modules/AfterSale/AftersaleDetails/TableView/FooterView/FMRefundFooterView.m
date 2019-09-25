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

CGFloat FMRefundFooterView_height = kSpaceValue + FMRefundExplainView_height + FMOrderContactUsViewHeight;

@interface FMRefundFooterView ()

@property (nonatomic, strong) FMRefundExplainView *explainView;

@property (nonatomic, strong) FMOrderContactUsView *contactUsView;

@end

@implementation FMRefundFooterView

- (void)fm_setupSubviews {
    
    _explainView = FMRefundExplainView.cv_viewFromNibLoad();
    [self addSubview:_explainView];
    
    _contactUsView = FMOrderContactUsView.cv_viewFromNibLoad();
    [self addSubview:_contactUsView];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    __block CGFloat offsetY = 0.f;
    offsetY += kSpaceValue;
    [_explainView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(offsetY);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(FMRefundExplainView_height);
    }];
    
    offsetY += FMRefundExplainView_height;
    [_contactUsView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self->_explainView.bottom);
        make.top.equalTo(offsetY);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(FMOrderContactUsViewHeight);
    }];
}

- (void)fm_bindViewModel {
    
}

@end
