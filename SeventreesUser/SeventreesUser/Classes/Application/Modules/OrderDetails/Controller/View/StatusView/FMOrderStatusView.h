//
//  FMOrderStatusView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#define      FMOrderStatusViewHeight    80.f

@interface FMOrderStatusView : FMView

@property (nonatomic, strong) NSNumber *orderStatus;

@property (nonatomic, strong) NSNumber *remainTime;

@end
