//
//  GCDDispatchManager.h
//  Chain-Master
//
//  Created by FMMac on 2019/4/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define      GCDDispatchMgr       [GCDDispatchManager shareManager]

NS_ASSUME_NONNULL_BEGIN

typedef dispatch_source_t (^CMGCDDispatchTimerSourceHandler)(NSTimeInterval, dispatch_block_t __nullable);

typedef void (^CMGCDDispatchTimerOperateHandler)(dispatch_source_t);


@interface GCDDispatchManager : NSObject

+ (instancetype)shareManager;

/** GCD延时执行 */
- (void (^)(NSTimeInterval, dispatch_block_t))afterByIntervalForCallback;

/** 生成GCD定时器源并立即开始 */
- (CMGCDDispatchTimerSourceHandler)timerByIntervalForCallback;

/** 继续(开始)GCD定时器 */
- (CMGCDDispatchTimerOperateHandler)resumeGCDTimer;

/** 取消GCD定时器 */
- (CMGCDDispatchTimerOperateHandler)cancelGCDTimer;

/** 暂停GCD定时器 */
- (CMGCDDispatchTimerOperateHandler)suspendGCDTimer;


@end

NS_ASSUME_NONNULL_END
