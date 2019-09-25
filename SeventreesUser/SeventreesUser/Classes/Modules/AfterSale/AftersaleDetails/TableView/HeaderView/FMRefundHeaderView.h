//
//  FMRefundHeaderView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat FMRefundHeaderView_height;

typedef NS_ENUM(NSUInteger, FMRefundHeaderViewStyle) {
    FMRefundHeaderViewStyleRefunding,           // 退款中
    FMRefundHeaderViewStyle1,
    FMRefundHeaderViewStyle2,
    FMRefundHeaderViewStyle3,
    FMRefundHeaderViewStyle4,
    FMRefundHeaderViewStyle5,
};

@interface FMRefundHeaderView : UIView

- (instancetype)initWithStyle:(FMRefundHeaderViewStyle)style;

@end
