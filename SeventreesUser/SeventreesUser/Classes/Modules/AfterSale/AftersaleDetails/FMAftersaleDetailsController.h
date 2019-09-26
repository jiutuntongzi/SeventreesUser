//
//  FMAftersaleDetailsController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewController.h"

typedef NS_ENUM(NSUInteger, FMAftersaleDetailsControllerStyle) {
    FMAftersaleDetailsControllerStyleRefunding,           // 退款中
    FMAftersaleDetailsControllerStyleWaitSend,            // 待发货
    FMAftersaleDetailsControllerStyleWaitReceive,         // 待验收
    FMAftersaleDetailsControllerStyle3,
    FMAftersaleDetailsControllerStyle4,
    FMAftersaleDetailsControllerStyle5,
};

@interface FMAftersaleDetailsController : FMViewController

@property (nonatomic, assign) FMAftersaleDetailsControllerStyle style;


@end
