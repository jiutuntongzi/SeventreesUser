//
//  FMScoreModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMScoreModel : FMModel

@property (nonatomic, strong) NSNumber *scoreId;

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, strong) NSNumber *integralNum;

@property (nonatomic, strong) NSNumber *storeId;

@property (nonatomic, strong) NSNumber *signType;

@property (nonatomic, copy) NSDictionary *extra;

@end

/*
 "extra": {},
 "id": 1,
 "integralNum": 1000,    --剩余积分总数
 "userId": 1,        --用户id可以不取
 "storeId": 1        --门店id可以不取
 "signType": 1            --1 已签到 0 未签到
 */
