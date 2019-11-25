//
//  UIViewController+SubscribeHUD.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RACCommand;   @class RACSubject;

@interface UIViewController (SubscribeHUD)

/** 订阅显示网络请求命令进度状态 */
+ (void)showRequestHUDStatus:(NSString *)status command:(RACCommand *)command;

/** 订阅显示状态信息 */
+ (void)showStatusInfoBySubject:(RACSubject *)subject;

@end

