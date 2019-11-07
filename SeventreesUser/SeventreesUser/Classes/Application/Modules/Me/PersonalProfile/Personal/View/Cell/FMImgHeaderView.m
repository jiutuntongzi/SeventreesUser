//
//  FMImgHeaderView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMImgHeaderView.h"

@interface FMImgHeaderView ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) IBOutlet UIImageView *headImgView;

@end

@implementation FMImgHeaderView

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = title;
}

- (void)setImageURLString:(NSString *)imageURLString {
    _imageURLString = imageURLString;
    
    [self->_headImgView sd_setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:[UIImage imageNamed:@"icon_personalHead"]];
}

@end
