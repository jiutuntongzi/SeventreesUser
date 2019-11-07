//
//  FMEvaluationTotalView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/4.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

extern const CGFloat FMEvaluationTotalViewHeight;

@interface FMEvaluationTotalView : FMView

@property (nonatomic, assign) NSInteger evaluateTotal;

@property (nonatomic, copy) void(^showAllCallback)(void);


@end
