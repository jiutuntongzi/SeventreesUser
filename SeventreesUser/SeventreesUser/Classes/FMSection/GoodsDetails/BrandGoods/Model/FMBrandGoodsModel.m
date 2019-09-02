//
//  FMBrandGoodsModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBrandGoodsModel.h"

@implementation FMBrandGoodsModel

/**
*  数组中需要转换的模型类
*
*  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
*/
+ (NSDictionary *)mj_objectClassInArray {
    /** 替换数组名：数组名：元素类型 */
    return @{
             @"couponEntities":@"FMCouponsModel",
             };
}

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"goods":@"a:goods",
             };
}

@end
