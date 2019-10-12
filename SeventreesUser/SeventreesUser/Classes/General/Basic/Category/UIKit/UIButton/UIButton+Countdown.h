//
//  UIButton+Countdown.h
//  YXIM
//
//  Created by mac123 on 2018/10/27.
//  Copyright © 2018年 wjh. All rights reserved.
//

#import <UIKit/UIKit.h>

/** button倒计时 封装 */
@interface UIButton (Countdown)

/** 开启倒计时，title中的%d为倒计时显示 eg. title:@"剩余%d秒" */
-(void)startWithLimit:(NSInteger)seconds title:(NSString *)title;

/** 结束倒计时 */
-(void)endCountdown;

@end
