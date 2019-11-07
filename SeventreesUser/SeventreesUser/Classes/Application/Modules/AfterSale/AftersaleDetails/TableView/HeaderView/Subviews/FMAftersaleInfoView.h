//
//  FMAftersaleInfoView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat FMAftersaleInfoView_height;

typedef NS_ENUM(NSUInteger, FMAftersaleInfoViewStyle) {
    FMAftersaleInfoViewStyleRefunding,           // 您已成功发起退款申请，请耐心等待商家处理
    FMAftersaleInfoViewStyleWaitSend,           // 您的退货申请已通过，填写发货信息
    FMAftersaleInfoViewStyleWaitReceive,           // 您的退货申请已通过，待商家验收
    FMAftersaleInfoViewStyleRefundFailure,           // 失败原因：商品已被顾客损坏，无法进行二次销售
};

@interface FMAftersaleInfoView : UIView

@property (nonatomic, assign) FMAftersaleInfoViewStyle style;

@end
