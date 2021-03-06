//
//  DCClassCategoryCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCClassCategoryCell.h"

// Controllers

// Models
#import "DCClassGoodsItem.h"

#import "CatogeryData.h"
// Views

// Vendors
#import "Masonry.h"

// Categories

// Others

@interface DCClassCategoryCell ()

/* 标题 */
@property (strong , nonatomic)UILabel *titleLabel;
/* 指示View */
@property (strong , nonatomic)UIView *indicatorView;

@end

@implementation DCClassCategoryCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:_titleLabel];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.hidden = NO;
    _indicatorView.backgroundColor = [UIColor colorWithRed:255.f/ 255.f green:0.f/ 255.f blue:132.f/ 255.f alpha:1.f];
    [self addSubview:_indicatorView];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.height.equalTo(@25);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(4);
    }];
}

#pragma mark - cell点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
        _titleLabel.textColor = [UIColor colorWithRed:255.f/ 255.f green:0.f/ 255.f blue:132.f/ 255.f alpha:1.f];;
    }else{
        _indicatorView.hidden = YES;
        _titleLabel.textColor = [UIColor blackColor];
    }
}

#pragma mark - Setter Getter Methods
- (void)setTitleItem:(CatogeryData *)titleItem
{
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.name;
}

@end
