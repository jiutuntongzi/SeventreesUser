//
//  FMRefundHeaderView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundHeaderView.h"
#import "MacroHeader.h"

#import "FMRefundStatusView.h"
#import "FMAftersaleInfoView.h"
#import "FMMarkTitleView.h"

#define      kSpaceValue      15.f

CGFloat FMRefundHeaderView_height = FMRefundStatusView_height + FMAftersaleInfoView_height + FMMarkTitleView_height + kSpaceValue;

@interface FMRefundHeaderView ()

@property (nonatomic, assign) FMRefundHeaderViewStyle style;

@property (nonatomic, strong) FMRefundStatusView *refundStatusView;

@property (nonatomic, strong) FMAftersaleInfoView *refundInfoView;

@property (nonatomic, strong) FMMarkTitleView *titleView;

@end

@implementation FMRefundHeaderView

- (instancetype)initWithStyle:(FMRefundHeaderViewStyle)style {
    if (self = [super init]) {
        self.style = style;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    switch (_style) {
        case FMRefundHeaderViewStyleRefunding: {
            
            _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
            // code..
            
            _refundInfoView = FMAftersaleInfoView.cv_viewFromNibLoad();
            // code..
            
            _titleView = FMMarkTitleView.cv_viewFromNibLoad();
            // code..
            
            self.cv_addSubviews(@[_refundStatusView, _refundInfoView, _titleView]);
            
            FMRefundHeaderView_height = FMRefundStatusView_height + FMAftersaleInfoView_height + FMMarkTitleView_height + kSpaceValue;
            
            break;
        }
        default: {
            break;
        }
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    switch (_style) {
        case FMRefundHeaderViewStyleRefunding: {
            __block CGFloat spaceValue = kSpaceValue;
            __block CGFloat offsetY = 0.f;
            [_refundStatusView makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self);
                make.height.equalTo(FMRefundStatusView_height);
            }];
            offsetY += FMRefundStatusView_height;
            [_refundInfoView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self->_refundStatusView.bottom);
                make.left.right.equalTo(self);
                make.height.equalTo(FMAftersaleInfoView_height);
            }];
            offsetY += FMAftersaleInfoView_height + spaceValue;
            [_titleView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(offsetY);
                make.left.right.equalTo(self);
                make.height.equalTo(FMMarkTitleView_height);
            }];
            
            
            
            break;
        }
        default: {
            break;
        }
    }
    
    [super updateConstraints];
}

@end
