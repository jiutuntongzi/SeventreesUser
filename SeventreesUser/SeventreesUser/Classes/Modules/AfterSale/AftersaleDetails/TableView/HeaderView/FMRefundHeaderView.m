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
#import "FMMoneyView.h"
#import "FMAddressView.h"
#import "FMTitleView.h"

#define      kSpaceValue      15.f

CGFloat FMRefundHeaderView_height = 0.f;

@interface FMRefundHeaderView ()

@property (nonatomic, assign) FMRefundHeaderViewStyle style;

@property (nonatomic, strong) FMRefundStatusView *refundStatusView;

@property (nonatomic, strong) FMAftersaleInfoView *refundInfoView;

@property (nonatomic, strong) FMMoneyView *moneyView;

@property (nonatomic, strong) FMAddressView *addressView;

@property (nonatomic, strong) FMMarkTitleView *titleView;

@property (nonatomic, strong) FMTitleView *terraceTitleView;

@end

@implementation FMRefundHeaderView

- (instancetype)initWithStyle:(FMRefundHeaderViewStyle)style {
    if (self = [super init]) {
        _style = style;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    if (_style == FMRefundHeaderViewStyleWaitSend || _style == FMRefundHeaderViewStyleWaitReceive) {
        _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
        _refundStatusView.status = (FMRefundStatusViewStyle)_style;
//        if (_style == FMRefundHeaderViewStyleWaitSend) {
//            _refundStatusView.status = FMRefundStatusViewStyleWaitSend;
//        } else if (_style == FMRefundHeaderViewStyleWaitReceive) {
//            _refundStatusView.status = FMRefundStatusViewStyleWaitReceive;
//        }
        // code..
        
        _refundInfoView = FMAftersaleInfoView.cv_viewFromNibLoad();
        if (_style == FMRefundHeaderViewStyleWaitSend) {
            _refundInfoView.style = FMAftersaleInfoViewStyleWaitSend;
        } else if (_style == FMRefundHeaderViewStyleWaitReceive) {
            _refundInfoView.style = FMAftersaleInfoViewStyleWaitReceive;
        }
        // code..
        
        _addressView = FMAddressView.cv_viewFromNibLoad();
        // code..
        
        _titleView = FMMarkTitleView.cv_viewFromNibLoad();
        // code..
        
        self.cv_addSubviews(@[_refundStatusView, _refundInfoView, _addressView, _titleView]);
        
        FMRefundHeaderView_height = FMRefundStatusView_height + FMAftersaleInfoView_height + FMAddressViewHeight + kSpaceValue + FMMarkTitleView_height + kSpaceValue;
        
    } else if (_style == FMRefundHeaderViewStyleRefundFailure) {
        _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
        _refundStatusView.status = FMRefundStatusViewStyleRefundFailure;
        // code..
        
        _refundInfoView = FMAftersaleInfoView.cv_viewFromNibLoad();
        _refundInfoView.style = FMAftersaleInfoViewStyleRefundFailure;
        // code..
        
        _moneyView = FMMoneyView.cv_viewFromNibLoad();
        
        _titleView = FMMarkTitleView.cv_viewFromNibLoad();
        // code..
        
        self.cv_addSubviews(@[_refundStatusView, _refundInfoView, _moneyView, _titleView]);
        
        FMRefundHeaderView_height = FMRefundStatusView_height + FMAftersaleInfoView_height + FMMoneyView_height + kSpaceValue + FMMarkTitleView_height + kSpaceValue;
        
    } else if (_style == FMRefundHeaderViewStyleSalesFailure) {
        _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
        _refundStatusView.status = FMRefundStatusViewStyleSalesFailure;
        // code..
        
        _refundInfoView = FMAftersaleInfoView.cv_viewFromNibLoad();
        _refundInfoView.style = FMAftersaleInfoViewStyleRefundFailure;
        // code..
        
        _moneyView = FMMoneyView.cv_viewFromNibLoad();
        
        _addressView = FMAddressView.cv_viewFromNibLoad();
        // code..
        
        _titleView = FMMarkTitleView.cv_viewFromNibLoad();
        // code..
        
        self.cv_addSubviews(@[_refundStatusView, _refundInfoView, _moneyView, _addressView, _titleView]);
        
        FMRefundHeaderView_height = FMRefundStatusView_height + FMAftersaleInfoView_height + FMMoneyView_height + kSpaceValue + FMAddressViewHeight + kSpaceValue + FMMarkTitleView_height + kSpaceValue;
        
    } else if (_style == FMRefundHeaderViewStyleSalesSuccess) {
        _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
        _refundStatusView.status = FMRefundStatusViewStyleSalesSuccess;
        // code..
        
        _moneyView = FMMoneyView.cv_viewFromNibLoad();
        // code..
        
        _terraceTitleView = FMTitleView.cv_viewFromNibLoad();
        // code..
        
        _addressView = FMAddressView.cv_viewFromNibLoad();
        // code..
        
        _titleView = FMMarkTitleView.cv_viewFromNibLoad();
        // code..
        
        self.cv_addSubviews(@[_refundStatusView, _moneyView, _terraceTitleView, _addressView, _titleView]);
        
        FMRefundHeaderView_height = FMRefundStatusView_height + FMMoneyView_height + kSpaceValue + FMTitleView_height + kSpaceValue + FMAddressViewHeight + kSpaceValue + FMMarkTitleView_height;
        
    } else if (_style == FMRefundHeaderViewStyleRefundSuccess) {
        _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
        _refundStatusView.status = FMRefundStatusViewStyleRefundSuccess;
        // code..
        
        _moneyView = FMMoneyView.cv_viewFromNibLoad();
        // code..
        
        _terraceTitleView = FMTitleView.cv_viewFromNibLoad();
        // code..
        
        _titleView = FMMarkTitleView.cv_viewFromNibLoad();
        // code..
        
        self.cv_addSubviews(@[_refundStatusView, _moneyView, _terraceTitleView, _titleView]);
        
        FMRefundHeaderView_height = FMRefundStatusView_height + FMMoneyView_height + kSpaceValue + FMTitleView_height + kSpaceValue + FMMarkTitleView_height;
        
    } else { // FMRefundHeaderViewStyleRefunding
        _refundStatusView = FMRefundStatusView.cv_viewFromNibLoad();
        _refundStatusView.status = FMRefundStatusViewStyleRefunding;
        // code..
        
        _refundInfoView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FMAftersaleInfoView class]) owner:nil options:nil].firstObject;
        _refundInfoView.style = FMAftersaleInfoViewStyleRefunding;
        // code..
        
        _titleView = FMMarkTitleView.cv_viewFromNibLoad();
        // code..
        
        self.cv_addSubviews(@[_refundStatusView, _refundInfoView, _titleView]);
        
        FMRefundHeaderView_height = FMRefundStatusView_height + FMAftersaleInfoView_height + FMMarkTitleView_height + kSpaceValue;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    if (_style == FMRefundHeaderViewStyleWaitSend || _style == FMRefundHeaderViewStyleWaitReceive) {
        __block CGFloat spaceValue = kSpaceValue, offsetY = 0.f;
        
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
        [_addressView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMAddressViewHeight);
        }];
        offsetY += FMAddressViewHeight + spaceValue;
        [_titleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMMarkTitleView_height);
        }];
        
    } else if (_style == FMRefundHeaderViewStyleRefundFailure || _style == FMRefundHeaderViewStyleSalesFailure) {
        __block CGFloat spaceValue = kSpaceValue, offsetY = 0.f;
        
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
        [_moneyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMMoneyView_height);
        }];
        
        offsetY += FMMoneyView_height + spaceValue;
        
        if (_style == FMRefundHeaderViewStyleSalesFailure) {
            [_addressView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(offsetY);
                make.left.right.equalTo(self);
                make.height.equalTo(FMAddressViewHeight);
            }];
            offsetY += FMAddressViewHeight + spaceValue;
        }
        
        [_titleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMMarkTitleView_height);
        }];
        
    } else if (_style == FMRefundHeaderViewStyleSalesSuccess || _style == FMRefundHeaderViewStyleRefundSuccess) {
        __block CGFloat spaceValue = kSpaceValue, offsetY = 0.f;
        
        [_refundStatusView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(FMRefundStatusView_height);
        }];
        offsetY += FMRefundStatusView_height;

        [_moneyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMMoneyView_height);
        }];
        
        offsetY += FMMoneyView_height + spaceValue;
        [_terraceTitleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMTitleView_height);
        }];
        
        offsetY += FMTitleView_height + spaceValue;
        
        if (_style == FMRefundHeaderViewStyleSalesSuccess) {
            [_addressView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(offsetY);
                make.left.right.equalTo(self);
                make.height.equalTo(FMAddressViewHeight);
            }];
            offsetY += FMAddressViewHeight + spaceValue;
        }
        
        [_titleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self);
            make.height.equalTo(FMMarkTitleView_height);
        }];
        
    } else { // FMRefundHeaderViewStyleRefunding
        __block CGFloat spaceValue = kSpaceValue, offsetY = 0.f;
        
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
    }

    [super updateConstraints];
}

@end
