//
//  UIViewController+SubscribeHUD.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "UIViewController+SubscribeHUD.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SVProgressHUD.h>

@implementation UIViewController (SubscribeHUD)

+ (void)showRequestHUDStatus:(NSString *)status command:(RACCommand *)command {
    [[command.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:status];
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
}

+ (void)showStatusInfoBySubject:(RACSubject *)subject {
    [subject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:0.5f];
    }];
}

@end
