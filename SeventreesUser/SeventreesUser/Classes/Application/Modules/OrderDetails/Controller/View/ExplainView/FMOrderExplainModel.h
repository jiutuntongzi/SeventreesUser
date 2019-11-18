//
//  FMOrderExplainModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/18.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMOrderExplainModel : FMModel

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, strong) NSString *createOrderTime;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *logisticsName;

@property (nonatomic, copy) NSString *logisticsCode;

@end
