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

/** status: 售后状态 (0等待处理, 1审核不通过, 2审核通过（退货中未填写物流）, 3审核通过（退款中/退货中已填写物流）,退款成功，4商家已验收) */
+ (void)showByPageType:(FMAftersaleDetailsControllerStyle)type refundId:(NSNumber *)refundId;

@end

