//
//  UIButton+Countdown.m
//  YXIM
//
//  Created by mac123 on 2018/10/27.
//  Copyright © 2018年 wjh. All rights reserved.
//

#import "UIButton+Countdown.h"
#import <objc/runtime.h>

static char *btn_count_down_timer = "btn_count_down_timer";
static char *btn_count_down_seconds = "btn_count_down_seconds";
static char *btn_count_down_title = "btn_count_down_title";
static char *btn_count_old_title = "btn_count_old_title";

@interface UIButton ()
@property (nonatomic , strong) NSTimer *priTimer;
@property (nonatomic , assign) NSNumber *priSeconds;
@property (nonatomic , copy) NSString *priTitle;
@property (nonatomic , copy) NSString *countOldBtnTitle;
@end


@implementation UIButton (Countdown)
-(void)startWithLimit:(NSInteger)seconds title:(NSString *)title {
    if (!self.priTimer) {
        self.countOldBtnTitle = self.titleLabel.text;
        self.priSeconds = @(seconds);
        self.priTitle = title;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownRunning) userInfo:nil repeats:YES];
        self.priTimer = timer;
        /** 添加线程防止滑动时定时器停止运行 */
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

-(void)countDownRunning {
    self.enabled = NO;
    NSInteger nowSeconds = self.priSeconds.integerValue;
    self.priSeconds = @(--nowSeconds);
    if (nowSeconds <= 0) {
        [self endCountdown];
        return;
    }
    NSString *replacedString = nil;
    BOOL resp1 = [self.priTitle containsString:@"%@"];
    BOOL resp2 = [self.priTitle containsString:@"%d"];
    BOOL resp3 = [self.priTitle containsString:@"%ld"];
    if (resp1) replacedString = @"%@";
    if (resp2) replacedString = @"%d";
    if (resp3) replacedString = @"%ld";
    if ((resp1 || resp2 || resp3) && self.priTitle.length && replacedString) {
        NSString *beTarget = [NSString stringWithFormat:@"%@",self.priSeconds];
        NSString *newTitle = [self.priTitle stringByReplacingOccurrencesOfString:replacedString withString:beTarget];
        [self setTitle:newTitle forState:UIControlStateDisabled];
    }else{
        [self setTitle:self.priTitle forState:UIControlStateDisabled];
    }
    
}

-(void)endCountdown {
    if (self.priTimer) {
        [self.priTimer invalidate];
        self.priTimer = nil;
        [self setTitle:self.countOldBtnTitle forState:UIControlStateNormal];
        self.enabled = YES;
    }
}

#pragma mark - add property
-(void)setPriTimer:(NSTimer *)priTimer{
    objc_setAssociatedObject(self, &btn_count_down_timer, priTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSTimer *)priTimer {
    return objc_getAssociatedObject(self, &btn_count_down_timer);
}
-(void)setPriSeconds:(NSNumber *)priSeconds {
    objc_setAssociatedObject(self, &btn_count_down_seconds, priSeconds, OBJC_ASSOCIATION_ASSIGN);
}
-(NSNumber *)priSeconds {
    return objc_getAssociatedObject(self, &btn_count_down_seconds);
}
-(void)setPriTitle:(NSString *)priTitle {
    objc_setAssociatedObject(self, &btn_count_down_title, priTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)priTitle {
    return objc_getAssociatedObject(self, &btn_count_down_title);
}

-(void)setCountOldBtnTitle:(NSString *)countOldBtnTitle {
    objc_setAssociatedObject(self, &btn_count_old_title, countOldBtnTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)countOldBtnTitle {
    return objc_getAssociatedObject(self, &btn_count_old_title);
}


@end
