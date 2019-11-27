//
//  FMRefundStatusView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#define      FMRefundStatusView_height    80.f

typedef NS_ENUM(NSUInteger, FMRefundStatusViewStyle) {
    FMRefundStatusViewStyleRefunding,        // 退款中
    FMRefundStatusViewStyleWaitSend,         // 审核通过，待用户发货
    FMRefundStatusViewStyleWaitReceive,      // 审核通过，待商家验收
    FMRefundStatusViewStyleRefundFailure,    // 退款失败
    FMRefundStatusViewStyleSalesFailure,     // 退货失败
    FMRefundStatusViewStyleRefundSuccess,    // 退款成功
    FMRefundStatusViewStyleSalesSuccess,     // 退货成功
};

@interface FMRefundStatusView : FMView

@property (nonatomic, assign) FMRefundStatusViewStyle status;

@property (nonatomic, copy) NSString *statusTime;

@property (nonatomic, strong) NSNumber *remainTime;

@end
