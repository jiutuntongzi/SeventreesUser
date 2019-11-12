//
//  FMGoodsInDetailModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMGoodsInDetailModel : FMModel

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, strong) NSNumber *goodsNum;

@property (nonatomic, strong) NSNumber *goodsPrice;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *goodsImage;

@end

/*
 {
 "goodsId": 16,    --商品id
 "goodsImage": "http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",--图片
 "goodsName": "奶粉",    --名字
 "goodsNum": 2,    --数量
 "goodsPrice": 0.00    --价格
 }
 */
