//
//  FMPictureCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPictureCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface FMPictureCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation FMPictureCell

- (void)setImgURLString:(NSString *)imgURLString {
    _imgURLString = imgURLString;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"testgoods"]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupSubviews];
//    }
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSubviews];
}

- (void)setupSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView = imgView;
    [self addSubview:imgView];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
