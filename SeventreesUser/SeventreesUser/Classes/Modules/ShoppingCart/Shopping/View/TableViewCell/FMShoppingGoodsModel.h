//
//  FMShoppingGoodsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMShoppingGoodsModel : FMModel

@property (assign, nonatomic) BOOL isEdit;
@property (assign, nonatomic) BOOL isChecked;


@property (nonatomic, strong) NSNumber *shoppingCarId;

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, strong) NSNumber *skuId;

@property (nonatomic, copy) NSString *imgURLStr;

@property (nonatomic, copy) NSString *goodsName;

/** --商品数量 */
@property (nonatomic, assign) NSUInteger goodsNum;

/** --商品单价 */
@property (nonatomic, strong) NSNumber *goodsPrice;

/** "颜色:蓝色,尺码:中码"  --sku信息 */
@property (nonatomic, copy) NSString *propertiesName;

@end

/*
"shoppingCarId": 1309,    --购物车id
"goodsId": 16,        --商品id
"skuId": 6,        --skuId
"goodsImage": "http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
"goodsName": "奶粉",    --商品名字
"goodsNum": 1,    --商品数量
"goodsPrice": 40.00000，    --商品单价
"propertiesName": "颜色:蓝色,尺码:中码"      --sku信息
*/
