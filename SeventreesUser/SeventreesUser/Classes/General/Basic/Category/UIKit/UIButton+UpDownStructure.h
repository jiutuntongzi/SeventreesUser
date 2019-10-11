//
//  UIButton+UpDownStructure.h
//  WJH_ITEM
//
//  Created by 今晨科技-ios开发 on 2017/6/20.
//  Copyright © 2017年 WJH_Item. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UpDownStructure)

/**
 *  给button设置上图下字结构
 *  @param image    图
 *  @param title    文字
 *  @param spacing  图文间距
 */
-(void)setVerticalStructureThatImg:(UIImage *)image Title:(NSString *)title Space:(CGFloat)spacing;

/**
 *  给button设置上图下字结构
 *  @param spacing 图文间距
 */
-(void)btnVerticalImageAndTitleSpace:(CGFloat)spacing;

@end
