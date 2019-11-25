//
//  FMSlashDetailsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMCategoryGoodsModel.h"
#import "FMBargainUserModel.h"

@interface FMSlashDetailsModel : FMModel

@property (nonatomic, strong) FMCategoryGoodsModel *goodsEntity;

@property (nonatomic, copy) NSArray<FMBargainUserModel *> *joinUserEntitys;

@end

/*
{
    "code": "OK",
    "message": "操作成功",
    "response": {
        "joinUser": [
                     {
                         "headUrl": "https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg",
                         "userName": "隔壁老六",
                         "time": "2019-10-11 17:31:29",
                         "price": 27.78
                     }
                     ],
        "goods": [
                  {
                      "id": 16,
                      "activityId": 1,
                      "url": "http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                      "name": "奶粉",
                      "activityType": "bargain",
                      "retailPrice": 12.00000,
                      "normalPrice": 213123.00000,
                      "num": 200,
                      "stock": 100,
                      "promotionDiscount": 2.00,
                      "promotionMax": 8.00,
                      "bargainDiscount": 1.0
                  }
                  ],
        "price1": 99.00, --当前价格
        "price2": 1.00--优惠价格,
        "minPrice":1.00--最低价格
    }
}

*/
