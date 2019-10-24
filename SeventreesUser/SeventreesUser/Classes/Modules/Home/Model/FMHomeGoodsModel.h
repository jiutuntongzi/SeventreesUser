//
//  FMHomeGoodsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMHomeGoodsModel : FMModel

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *name;

/** --商品类型  group:拼团;   parcel:限时包邮;    bargain:砍价； normal:普通商品 */
@property (nonatomic, copy) NSString *activityType;

@property (nonatomic, strong) NSNumber *activityId;

@property (nonatomic, strong) NSNumber *normalPrice;

@property (nonatomic, strong) NSNumber *retailPrice;

@property (nonatomic, strong) NSNumber *stock;

@property (nonatomic, strong) NSNumber *num;

@property (nonatomic, strong) NSNumber *bargainDiscount;

@property (nonatomic, strong) NSNumber *promotionDiscount;

@property (nonatomic, strong) NSNumber *promotionMax;

@end

