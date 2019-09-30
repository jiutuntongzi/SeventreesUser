//
//  FMNavSearchBarView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/22.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMNavSearchBarView.h"
#import "SearchBarView.h"

@interface FMNavSearchBarView ()

@property (nonatomic, strong) SearchBarView *searchBarView;

@property (nonatomic, strong) UIButton *returnbutton;

@end

@implementation FMNavSearchBarView

- (void)updateConstraints {
    CGFloat btnWidth = 40.f;

    [_returnbutton makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(btnWidth);
    }];
    
    [_searchBarView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30.f);
        make.top.bottom.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    /// 返回上一页按钮
    UIButton *customButton = UIButton.cb_button();
    _returnbutton = customButton;
    customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:customButton];
    __weak typeof(self) weakSelf = self;
    customButton.cb_setImageOfNamed(@"icon_navBack").cc_setActionEventsCallback(UIControlEventTouchUpInside, ^(UIButton *button) {
        if (weakSelf.prevPageCallback) weakSelf.prevPageCallback();
    });
    
    /// 输入搜索栏
    _searchBarView = SearchBarView.cv_viewFromNibLoad();
    [self addSubview:_searchBarView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    
}

@end
