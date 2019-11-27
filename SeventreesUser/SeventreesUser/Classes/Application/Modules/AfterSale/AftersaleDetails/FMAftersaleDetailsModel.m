//
//  FMAftersaleDetailsModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAftersaleDetailsModel.h"

@implementation FMAftersaleDetailsModel

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"statusTime": @"lastModifiedDateTime",
             @"logisticsCompany": @"distribution"
             };
}

@end
