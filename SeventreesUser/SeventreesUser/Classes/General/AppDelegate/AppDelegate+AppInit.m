//
//  AppDelegate+AppInit.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "AppDelegate+AppInit.h"
#import <objc/runtime.h>
#import "MainTabBarController.h"

@implementation AppDelegate (AppInit)

#pragma mark ——— <Swizzle system method>

-(BOOL)fm_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self fm_loadWindowRootController];
    
    /**注册微信*/
//    [WXApi registerApp:WxAppId];
    
    return [self fm_application:application didFinishLaunchingWithOptions:launchOptions];
}

-(BOOL)fm_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    /**转接url处理对象*/
//    [WXApi handleOpenURL:url delegate:[WeChatConfig shareCfg]];
//    [self _alipayHandleUrl:url];
    //    [YxShareManager handleOpenUrl:url];
    return [self fm_application:app openURL:url options:options];
}

-(BOOL)fm_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    /**转接url处理对象*/
//    [WXApi handleOpenURL:url delegate:[WeChatConfig shareCfg]];
//    [self _alipayHandleUrl:url];
    //    [YxShareManager handleOpenUrl:url];
    return [self fm_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

-(void)fm_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    [self fm_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

#pragma mark ——— <Private method>

- (void)fm_loadWindowRootController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BOOL isLogged = YES;
    if (isLogged) {
        self.rootViewController = [[MainTabBarController alloc] init];
        self.window.rootViewController = self.rootViewController;
        
    } else {
        UIViewController *loginVC = [[NSClassFromString(@"FMSetPasswordController") alloc] init];
        self.window.rootViewController = loginVC;
    }
}

- (void)nonHandle {
    NSLog(@"To avoid an infinite loop , do nothing");
}

#pragma mark ——— <Method swizzle>

BOOL fm_clsMethodSwizzle(Class cls , SEL originalSel , SEL swizzleSel ,SEL nopSel) {
    Method oriMethod = class_getInstanceMethod(cls, originalSel);
    Method swiMethod = class_getInstanceMethod(cls, swizzleSel);
    BOOL isAddMethod = class_addMethod(cls,
                                       originalSel,
                                       method_getImplementation(swiMethod),
                                       method_getTypeEncoding(swiMethod));
    if (isAddMethod == NO) {
        method_exchangeImplementations(oriMethod, swiMethod);
    } else {
        Method nopFunc = class_getInstanceMethod(cls, nopSel);
        class_replaceMethod(cls, swizzleSel, method_getImplementation(nopFunc), method_getTypeEncoding(nopFunc));
    }
    return YES;
}

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fm_clsMethodSwizzle([self class], @selector(application:didFinishLaunchingWithOptions:), @selector(fm_application:didFinishLaunchingWithOptions:),@selector(nonHandle));
        
        fm_clsMethodSwizzle([self class], @selector(application:openURL:options:), @selector(fm_application:openURL:options:),@selector(nonHandle));
        
        fm_clsMethodSwizzle([self class], @selector(application:openURL:sourceApplication:annotation:), @selector(fm_application:openURL:sourceApplication:annotation:),@selector(nonHandle));
        
        fm_clsMethodSwizzle([self class], @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:), @selector(fm_application:didRegisterForRemoteNotificationsWithDeviceToken:),@selector(nonHandle));
    });
}

@end
