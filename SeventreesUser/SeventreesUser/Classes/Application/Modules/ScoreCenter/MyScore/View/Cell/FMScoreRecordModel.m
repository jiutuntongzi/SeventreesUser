//
//  FMScoreRecordModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreRecordModel.h"

@implementation FMScoreRecordModel

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"scoreId":@"id",
             @"title":@"titile",
             @"subTitle":@"createdDateTime",
             };
}

@end
