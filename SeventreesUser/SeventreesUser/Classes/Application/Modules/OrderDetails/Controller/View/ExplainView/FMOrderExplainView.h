//
//  FMOrderExplainView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMOrderExplainModel.h"

#define      FMOrderExplainViewHeight    134.f

@interface FMOrderExplainView : FMView

@property (nonatomic, strong) FMOrderExplainModel *orderExplainEntity;

@property (nonatomic, copy) NSString *orderInfoText;

@end
