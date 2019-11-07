//
//  DCBrandsSortHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBrandsSortHeadView.h"

// Controllers

// Models
#import "DCClassMianItem.h"

// Views

// Vendors
#import "Masonry.h"

// Categories

// Others

@interface DCBrandsSortHeadView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

@end

@implementation DCBrandsSortHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI
{
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = [UIFont systemFontOfSize:16.f];
    _headLabel.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc] init];
    
    line.backgroundColor = [UIColor colorWithRed:220.f / 255.f green:220.f / 255.f blue:220.f / 255.f alpha:1.0f];
    [self addSubview:line];
    [self addSubview:_headLabel];
    
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self);
        make.height.equalTo(self.mas_height);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.equalTo(@0.5);
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(self.headLabel.mas_width).offset(120);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(NSString *)headTitle
{
    _headTitle = headTitle;
    _headLabel.text = [NSString stringWithFormat:@"  %@  ",headTitle];
}

@end
