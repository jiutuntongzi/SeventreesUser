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
    FMAftersaleDetailsControllerStyleRefundFailure,       // 退款失败
    FMAftersaleDetailsControllerStyleSalesFailure,        // 退货失败
    FMAftersaleDetailsControllerStyleRefundSuccess,       // 退款成功
    FMAftersaleDetailsControllerStyleSalesSuccess,        // 退货成功
};

@interface FMAftersaleDetailsController : FMViewController

@property (nonatomic, assign) FMAftersaleDetailsControllerStyle pageType;

@end

