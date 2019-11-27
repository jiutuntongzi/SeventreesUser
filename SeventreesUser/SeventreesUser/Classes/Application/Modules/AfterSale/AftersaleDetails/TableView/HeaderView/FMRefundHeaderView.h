//
//  FMRefundHeaderView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMAftersaleDetailsModel.h"

extern CGFloat FMRefundHeaderView_height;

typedef NS_ENUM(NSUInteger, FMRefundHeaderViewStyle) {
    FMRefundHeaderViewStyleRefunding,        // 退款中
    FMRefundHeaderViewStyleWaitSend,         // 审核通过，待用户发货
    FMRefundHeaderViewStyleWaitReceive,      // 审核通过，待商家验收
    FMRefundHeaderViewStyleRefundFailure,    // 退款失败
    FMRefundHeaderViewStyleSalesFailure,     // 退货失败
    FMRefundHeaderViewStyleRefundSuccess,    // 退款成功
    FMRefundHeaderViewStyleSalesSuccess,     // 退货成功
};

@interface FMRefundHeaderView : UIView

- (instancetype)initWithStyle:(FMRefundHeaderViewStyle)style;

@property (nonatomic, strong) FMAftersaleDetailsModel *refundEntity;

@end
