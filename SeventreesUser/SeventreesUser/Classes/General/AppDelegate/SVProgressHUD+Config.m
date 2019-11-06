//
//  SVProgressHUD+Config.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "SVProgressHUD+Config.h"

@implementation SVProgressHUD (Config)

+ (void)fm_globalConfig {
    [SVProgressHUD dismissWithDelay:1.0f];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.1f alpha:0.05f]];
//    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
}

@end
