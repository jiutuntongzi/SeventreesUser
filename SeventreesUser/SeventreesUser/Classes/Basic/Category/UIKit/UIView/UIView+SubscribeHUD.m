//
//  UIView+SubscribeHUD.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "UIView+SubscribeHUD.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SVProgressHUD.h>

@implementation UIView (SubscribeHUD)

+ (void)showRequestHUDStatus:(NSString *)status command:(RACCommand *)command {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [[command.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:status];
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
}

+ (void)showStatusInfoBySubject:(RACSubject *)subject {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [subject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
}

@end
