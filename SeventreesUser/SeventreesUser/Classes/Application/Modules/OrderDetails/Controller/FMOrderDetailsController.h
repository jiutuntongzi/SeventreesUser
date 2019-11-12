//
//  FMOrderDetailsController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewController.h"

typedef NS_ENUM(NSUInteger, FMOrderDetailsPageStyle) {
    FMOrderDetailsPageStyleWaitPay,
    FMOrderDetailsPageStyleWaitSend,
    FMOrderDetailsPageStyleWaitReceive,
    FMOrderDetailsPageStyleWaitEvaluate,
    FMOrderDetailsPageStyleYetEvaluate,
    FMOrderDetailsPageStyleYetCancel
};

@interface FMOrderDetailsController : FMViewController

@property (nonatomic, assign) FMOrderDetailsPageStyle type;

@property (nonatomic, strong) NSNumber *orderId;

+ (void)showByType:(FMOrderDetailsPageStyle)type orderId:(NSNumber *)orderId fromController:(UIViewController *)fromVC;

@end
