//
//  FMOrderDetailsController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewController.h"

typedef NS_ENUM(NSUInteger, FMOrderDetailsPageStyle) {
    FMOrderDetailsPageStyleWaitPay      = 1,
    FMOrderDetailsPageStyleWaitSend     = 2,
    FMOrderDetailsPageStyleWaitReceive  = 3,
    FMOrderDetailsPageStyleWaitEvaluate = 4,
    FMOrderDetailsPageStyleYetCancel    = 9,
    FMOrderDetailsPageStyleYetFinish    = 11,
};

@interface FMOrderDetailsController : FMViewController

@property (nonatomic, assign) FMOrderDetailsPageStyle type;

@property (nonatomic, strong) NSNumber *orderId;

+ (void)showByType:(FMOrderDetailsPageStyle)type orderId:(NSNumber *)orderId fromController:(UIViewController *)fromVC;

@end
