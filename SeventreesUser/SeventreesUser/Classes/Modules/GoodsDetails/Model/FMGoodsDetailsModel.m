//
//  FMGoodsDetailsModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsModel.h"



@implementation FMGoodsDetailsSpellGroupGoodsMsgModel

@end


@implementation FMGoodsDetailsShowImagesExtraModel

@end


@implementation FMGoodsDetailsShowImagesModel

@end


@implementation FMGoodsDetailsOrdinaryGoodsMsgModel

@end


@implementation FMGoodsDetailsGoodsSkusExtraModel

@end


@implementation FMGoodsDetailsGoodsSkuModel

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

@end


@implementation FMGoodsDetailsActivityGoodsMsgModel

@end


@implementation FMGoodsDetailsBargainingGoodsMsgModel

@end


@implementation FMGoodsDetailsCommentssExtraModel

@end


@implementation FMGoodsDetailsCommentsModel

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"evaluateId": @"id"};
}

@end


@implementation FMGoodsDetailsImagesExtraModel

@end


@implementation FMGoodsDetailsImagesModel

@end


@implementation FMGoodsDetailsModel

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"showImages":             @"FMGoodsDetailsShowImagesModel",
             @"goodsSkuModels":         @"FMGoodsDetailsGoodsSkuModel",
             @"goodsCommentsModels":    @"FMGoodsDetailsCommentsModel",
             @"detailsImages":          @"FMGoodsDetailsImagesModel",
             @"apiPmCommentsImgs":      @"FMImageEyeModel",
             };
}

@end


