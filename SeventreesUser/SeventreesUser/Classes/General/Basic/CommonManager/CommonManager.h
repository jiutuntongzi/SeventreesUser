//
//  CommonManager.h
//  Chain-Master
//
//  Created by FMMac on 2019/4/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GCDDispatchManager.h"

#define      commonMgr       [CommonManager shareCommonManager]

NS_ASSUME_NONNULL_BEGIN

typedef void (^CMImageDownComplete)(UIImage * __nullable);

typedef void (^CMScanQRCodeComplete)(NSString * __nullable);

typedef void (^ __nullable CMFailureErrorBlock)(NSString * __nullable);


@interface CommonManager : NSObject


+ (instancetype)shareCommonManager;

/** GCD管理单例 */
- (GCDDispatchManager *)gcdDispatchInstance;


/** 获取窗口最顶部(当前显示)的控制器 */
- (UIViewController * (^)(void))topViewController;

/**
 异步加载图片
 e.g.
 NSString *imgURLString = @"http://dpic.tiankong.com/x8/9w/QJ8865599550.jpg";
 @weakify(self)
 commonMgr.asyncDownImageByURLString(imgURLString, ^(UIImage * __nullable image) {
    weak_self.imageView.image = image;
    DLog(@"currentThread == %@", [NSThread currentThread]);
 });
 */
- (void (^)(NSString *, CMImageDownComplete))asyncDownImageByURLString;

/** 固定宽，求拉伸的等比高度 */
- (CGFloat (^)(CGFloat, CGSize))scaleHeightByFixedWidthChangeSize;

/**
 显示二维码扫描页并在扫码完成时回调结果
 e.g.
 commonMgr.showScanQRCodeComplete(^(NSString *resultQRCodeString) {
    DLog(@"resultQRCodeString == %@", resultQRCodeString);
 }, ^(NSString *errorDescr) {
    DLog(@"errorDescr == %@", errorDescr);
 });
 */
- (void (^)(CMScanQRCodeComplete, CMFailureErrorBlock __nullable))showScanQRCodeComplete;

/** 生成二维码图片
 e.g.
 commonMgr.imageQRCodeByStringSize(qrCodeString, 100.f);
 */
- (UIImage * __nullable (^)(NSString *, CGFloat))imageQRCodeByStringSize;

/** 识别二维码/条形码 */
- (NSString * __nullable (^)(UIImage *))discernBarQRCodeImage;

@end

NS_ASSUME_NONNULL_END
