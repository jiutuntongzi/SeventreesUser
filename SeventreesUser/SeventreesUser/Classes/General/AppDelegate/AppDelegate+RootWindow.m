//
//  AppDelegate+RootWindow.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "AppDelegate+RootWindow.h"

#import "UserData.h"
#import "FMLoginController.h"
#import "MainTabBarController.h"

@implementation AppDelegate (RootWindow)

- (void)fm_loadWindowRootController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    void (^initRootVCHandle)(void) = ^{
        self.rootViewController = [[MainTabBarController alloc] init];
        self.window.rootViewController = self.rootViewController;
    };
    
    NSLog(@"\n登录令牌：token == %@\n", [UserData token]);
    BOOL isLogged = [UserData token] != nil;
    if (isLogged) {
        initRootVCHandle();
        return;
    }
    
    FMLoginController *loginVC = [[FMLoginController alloc] init];
    self.window.rootViewController = loginVC;
    loginVC.loginSuccessBlock = ^{
        initRootVCHandle();
    };
}

@end
