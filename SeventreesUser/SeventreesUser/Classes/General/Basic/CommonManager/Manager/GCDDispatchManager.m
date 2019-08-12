//
//  GCDDispatchManager.m
//  Chain-Master
//
//  Created by FMMac on 2019/4/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "GCDDispatchManager.h"

@implementation GCDDispatchManager

#pragma mark ——— 完整单例

static GCDDispatchManager * _instance = nil;

+ (instancetype)shareManager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


#pragma mark ——— Public Interface

/** GCD延时执行 */
- (void (^)(NSTimeInterval, dispatch_block_t))afterByIntervalForCallback {
    return ^(NSTimeInterval timeInterval, dispatch_block_t handler) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), handler);
    };
}

/** 生成GCD定时器源并立即开始 */
- (CMGCDDispatchTimerSourceHandler)timerByIntervalForCallback {
    
    return ^(NSTimeInterval timeInterval, dispatch_block_t __nullable handler) {
        dispatch_source_t timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        /// GCD的时间参数一般是纳秒（1秒 == 10的9次方纳秒），delta：比当前时间晚0秒开始
        dispatch_time_t timeNow = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
        uint64_t interval = (uint64_t)(timeInterval * NSEC_PER_SEC);
        dispatch_source_set_timer(timerSource, timeNow, interval, 0);
        dispatch_source_set_event_handler(timerSource, handler);
        dispatch_resume(timerSource); // 立即开始
        
        return timerSource;
    };
}

/** 继续(开始)GCD定时器 */
- (CMGCDDispatchTimerOperateHandler)resumeGCDTimer {
    return ^(dispatch_source_t timerSource) {
        dispatch_resume(timerSource);
    };
}

/** 取消GCD定时器 */
- (CMGCDDispatchTimerOperateHandler)cancelGCDTimer {
    return ^(dispatch_source_t timerSource) {
        dispatch_cancel(timerSource);
    };
}

/** 暂停GCD定时器 */
- (CMGCDDispatchTimerOperateHandler)suspendGCDTimer {
    return ^(dispatch_source_t timerSource) {
        dispatch_suspend(timerSource);
    };
}

@end
