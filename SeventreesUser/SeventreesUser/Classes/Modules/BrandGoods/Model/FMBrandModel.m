//
//  FMBrandModel.m
//  YBModelFileDemo
//
//  Created by indulgeIn on 2019/10/22.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import "FMBrandModel.h"


@implementation FMBrandExtraModel

@end


@implementation FMBrandInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end


@implementation FMBrandModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"brandInfoEntity": @"brand",
             @"goodsEntitys": @"goodsModel"
             };
}

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray {
    /** 替换数组名：{数组名：元素类型} */
    return @{@"goodsEntitys": @"FMHomeGoodsModel"};
}

@end


