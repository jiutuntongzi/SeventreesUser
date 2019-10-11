//
//  UIButton+UpDownStructure.m
//  WJH_ITEM
//
//  Created by 今晨科技-ios开发 on 2017/6/20.
//  Copyright © 2017年 WJH_Item. All rights reserved.
//

#import "UIButton+UpDownStructure.h"

@implementation UIButton (UpDownStructure)


-(void)setVerticalStructureThatImg:(UIImage *)image Title:(NSString *)title Space:(CGFloat)spacing{
    if (!title.length && !image)    return;
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setImage:image forState:UIControlStateNormal];
    [self btnVerticalImageAndTitleSpace:spacing];
}


- (void)btnVerticalImageAndTitleSpace:(CGFloat)spacing{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize  = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if(titleSize.width+0.5< frameSize.width) {
        titleSize.width= frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height+ titleSize.height+ spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight-imageSize.height),0.0,0.0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight-titleSize.height),0);
}

@end
