//
//  CommonManager.m
//  Chain-Master
//
//  Created by FMMac on 2019/4/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommonManager.h"
#import "MacroHeader.h"

static CommonManager * _instance = nil;

@implementation CommonManager

#pragma mark ——— 完整单例

+ (instancetype)shareCommonManager {
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

- (GCDDispatchManager *)gcdDispatchInstance {
    return [GCDDispatchManager shareManager];
}


- (UIViewController * (^)(void))topViewController {
    return ^() {
        UIViewController *resultVC = nil;
        resultVC = [self cm_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
        while (resultVC.presentedViewController) {
            resultVC = [self cm_topViewController:resultVC.presentedViewController];
        }
        return resultVC;
    };
}

- (void (^)(NSString *, CMImageDownComplete))asyncDownImageByURLString {
    
    return ^(NSString *imageURLString, CMImageDownComplete complete) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            UIImage *image = self.imageDownByURLString(imageURLString);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (complete) complete(image);
            });
        });
    };
}

- (CGFloat (^)(CGFloat, CGSize))scaleHeightByFixedWidthChangeSize {
    return ^(CGFloat fixedWidth, CGSize changesize) {
        // e.g. 已知固定itemCell宽，变化的商品图宽、高，求Cell等比高度
        // itemWidth * shopImageView.h / shopImageView.w
        return fixedWidth * changesize.height / changesize.width;
    };
}

- (void (^)(CMScanQRCodeComplete, CMFailureErrorBlock __nullable))showScanQRCodeComplete {
    
    return ^(CMScanQRCodeComplete complete, CMFailureErrorBlock failure) {
//         查看媒体设备的授权状态：AVMediaTypeVideo 表示摄像头使用的授权状态
//         AVAuthorizationStatusRestricted    表示受到限制
//         AVAuthorizationStatusDenied        表示拒绝访问
//         AVAuthorizationStatusNotDetermined 表示用户没有明确选择是否能够问相机
//         AVAuthorizationStatusAuthorized    表示已经授权访问
        
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (authorizationStatus) {
            case AVAuthorizationStatusNotDetermined: {
                if (failure) failure(@"相机访问受限，您没有选择是否允许App访问相机！");
                return;
            }
            case AVAuthorizationStatusRestricted: {
                if (failure) failure(@"相机访问受限，请开启App相机访问权限！");
                return;
            }
            case AVAuthorizationStatusDenied: {
                if (failure) failure(@"相机访问被拒绝，请授权App访问相机！");
                return;
            }
            default:
                break;
        }
        
        /// 能到这表示已授权相机访问
        ZFScanViewController *scanQRCodeVC = [[ZFScanViewController alloc] init];
        self.topViewController().cvc_presentVCAnimatedCompletion(scanQRCodeVC, NO, nil);
        
        scanQRCodeVC.returnScanBarCodeValue = ^(NSString *resultQRCodeString) {
            if (!resultQRCodeString.length) {
                !failure ?: failure(@"扫码失败：无效二维码(nil)！");
                return;
            }
            // 到这扫码成功
            if (complete) complete(resultQRCodeString);
        };
    };
}

- (UIImage * __nullable (^)(NSString *, CGFloat))imageQRCodeByStringSize {
    return ^(NSString *QRCodeString, CGFloat size) {
        return [UIImage imageForCodeString:QRCodeString size:size color:[UIColor blackColor] pattern:kCodePatternForQRCode];
    };
}

- (NSString * __nullable (^)(UIImage *))discernBarQRCodeImage {
    return ^(UIImage *image) {
        NSData *imageData = UIImagePNGRepresentation(image);
        CIImage *ciImage = [CIImage imageWithData:imageData];
        // 创建探测器     可选参数：CIDetectorAccuracyLow
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
        NSArray *features = [detector featuresInImage:ciImage]; // 发现特征
        NSString *content; // 取出探测到的内容
        for (CIQRCodeFeature *feature in features) {
            content = feature.messageString;
        }
        return content; // 返回进行处理(音效、网址分析、页面跳转等)
    };
}

#pragma mark ——— Private Interface

- (UIViewController *)cm_topViewController:(UIViewController *)controller {
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return [self cm_topViewController:[(UINavigationController *)controller topViewController]];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        return [self cm_topViewController:[(UITabBarController *)controller selectedViewController]];
    } else {
        return controller;
    }
}

- (UIImage * __nullable (^)(NSString *))imageDownByURLString {
    return ^(NSString *imageURLString) {
        imageURLString = imageURLString.cs_encodedString();
        NSData* imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]];
        UIImage* image = [UIImage imageWithData:imgData];
        return image;
    };
}

@end
