//
//  FMBargainDetailsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMSlashInGoodsModel.h"
#import "FMGoodsSKUModel.h"

@interface FMBargainDetailsModel : FMModel

@property (nonatomic, copy) NSArray<FMGoodsSKUModel *> *goodsSKUEntitys;

@property (nonatomic, copy) NSArray<FMSlashInGoodsModel *> *goodsEntitys;

@end

/*
"response": {
    "skus": [
             {
                 "extra": {},
                 "dr": "N",
                 "createdId": 0,
                 "createdDateTime": "",
                 "lastModifiedId": 0,
                 "lastModifiedDateTime": "",
                 "goodsId": 17,       --商品ID
                 "activityId": 186,    --活动ID
                 "id": 1,    --skuid
                 "normalPrice": 12312.00000,    --市场价
                 "propertiesName": "{\"颜色\":\"红色\",\"尺码\":\"大码\"}",    --sku参数
                 "retailPrice": 50.00000,    --零售价
                 "salePrice": 100.00,    --活动价
                 "skuCode": "01010100000101",    --sku编码
                 "      virtualSales": 100,    --虚拟销量
                 "stock": 100, --库存
                 "picUrl": "http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",--图片
                 "sales": 100    --销量
             }
             ],
    "goods": [
              {
                  "id": 17,
                  "url": "http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                  "name": "合成天下",
                  "activityType": "ACTIVITY_KJ",
                  "retailPrice": 8.00000
              }
              ]
    }
*/
