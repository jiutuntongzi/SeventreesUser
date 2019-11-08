//
//  FMScoreRecordModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMScoreRecordModel : FMModel

@property (nonatomic, strong) NSNumber *scoreId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) NSNumber *expendIntegral;

@property (nonatomic, strong) NSNumber *expendType;

@property (nonatomic, copy) NSDictionary *extra;

@property (nonatomic, copy) NSString *dr;

@end

/*
 {
 "extra": {},
 "id": 2,
 "dr": "N",
 "createdDateTime": "2019-09-16 17:08:58",  --时间
 "titile": "每日签到",        --标题
 "expendIntegral": 2，        --出入分数
 "expendType": 1        --1加 2减
 }
 */
