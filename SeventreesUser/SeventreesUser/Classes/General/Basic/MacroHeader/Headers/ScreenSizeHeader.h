//
//  ScreenSizeHeader.h
//  Chain-Master
//
//  Created by FMMac on 2019/4/5.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef ScreenSizeHeader_h
#define ScreenSizeHeader_h


#define      SCREEN_B        [[UIScreen mainScreen] bounds]
#define      SCREEN_W        ([[UIScreen mainScreen] bounds].size.width)
#define      SCREEN_H        ([[UIScreen mainScreen] bounds].size.height)

#define      kFixedHeight 44.f

#define      kNavBarHeight        self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height

#define      kStatusBarHeight     [[UIApplication sharedApplication] statusBarFrame].size.height

#define      kISPhoneX             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define IPHONE_4S (fabs((double)SCREEN_H - (double)480) < DBL_EPSILON)
#define IPHONE_5  (fabs((double)SCREEN_H - (double)568) < DBL_EPSILON)
#define IPHONE_6  (fabs((double)SCREEN_H - (double)667) < DBL_EPSILON)
#define IPHONE_6P (fabs((double)SCREEN_H - (double)736) < DBL_EPSILON)
#define IPHONE_7 IPHONE_6
#define IPHONE_7P IPHONE_6P
#define IPHONE_8 IPHONE_6
#define IPHONE_8P IPHONE_6P
#define IPHONE_X (fabs((double)SCREEN_H - (double)812) < DBL_EPSILON)
#define IPHONE_XS IPHONE_X
#define IPHONE_XS_MAX (fabs((double)SCREEN_H - (double)896) < DBL_EPSILON)
#define IPHONE_XR (fabs((double)SCREEN_H - (double)896) < DBL_EPSILON)


/** 安全区的高度 判断是否为 iPhone X、XR、XS、XS Max 几款机型 */
#define HasSafeArea ({\
BOOL isSafeArea = NO;\
if (@available(iOS 11.0, *)) {\
isSafeArea = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}else{\
isSafeArea = IPHONE_X || IPHONE_XR || IPHONE_XS || IPHONE_XS_MAX;\
}\
(isSafeArea);\
})


#endif /* ScreenSizeHeader_h */
