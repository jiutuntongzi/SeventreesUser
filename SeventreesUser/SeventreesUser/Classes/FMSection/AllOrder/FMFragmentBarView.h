//
//  FMFragmentBarView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMFragmentBarView : UIView

/** 默认0:线上订单 / 1：门店消费 */
@property (nonatomic, assign) UInt8 type;

@property (nonatomic, copy) void(^actionCallback)(UInt8 type);

@end
