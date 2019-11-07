//
//  FMHomeGoodsModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeGoodsModel.h"

@implementation FMHomeGoodsModel

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"goodsId": @"id",
             @"imgUrl": @"url",
             };
}

@end
