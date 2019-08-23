//
//  DCBrandSortCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBrandSortCell.h"

// Controllers

// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
// Views

// Vendors
#import "UIImageView+WebCache.h"
#import "Masonry.h"

// Categories
#import "UIView+Frame.h"

// Others

@interface DCBrandSortCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *brandImageView;

@property (strong , nonatomic)UILabel *titleLabel;

@end

@implementation DCBrandSortCell

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
    _brandImageView = [[UIImageView alloc] init];
    _brandImageView.clipsToBounds = YES;
    _brandImageView.contentMode = UIViewContentModeScaleAspectFill;
    _brandImageView.layer.masksToBounds = YES;
    _brandImageView.layer.cornerRadius = (self.width-24)/2;
    _brandImageView.layer.borderWidth = 1;
    _brandImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;

    [self addSubview:_brandImageView];
    [_brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self).offset(20);
        make.width.mas_equalTo(self.width-24);
        make.height.mas_equalTo(self.width-24);
        make.centerX.equalTo(self);
    }];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"哈哈";
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.brandImageView.mas_bottom).offset(6);
        make.centerX.mas_equalTo(self);
        make.height.equalTo(@30);
        make.width.equalTo(self);
    }];
}

#pragma mark - 布局
- (void)layoutSubviews
{

}

#pragma mark - Setter Getter Methods
- (void)setSubItem:(Brand *)subItem
{
    _subItem = subItem;
    
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:subItem.logoUrl] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
//    [_brandImageView loadIamgeWithUrlStr:subItem.logoUrl];
    _titleLabel.text = subItem.name;
}

@end
