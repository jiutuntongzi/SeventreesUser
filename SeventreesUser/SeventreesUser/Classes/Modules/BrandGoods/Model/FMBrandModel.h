//
//  FMBrandModel.h
//  YBModelFileDemo
//
//  Created by indulgeIn on 2019/10/22.
//  Copyright © 2019 indulgeIn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMHomeGoodsModel.h"

@interface FMBrandExtraModel : NSObject

@end

@interface FMBrandInfoModel : NSObject

@property (nonatomic, assign) NSNumber *ID;

@property (nonatomic, copy) NSString *backgroundUrl;

@property (nonatomic, copy) NSString *details;

@property (nonatomic, copy) NSString *logoUrl;

/** 自定义商品总件数（非JSON转Model数据）*/
@property (nonatomic, assign) NSNumber *goodsTotal;

@property (nonatomic, copy) NSString *createdDateTime;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSNumber *lastModifiedId;

@property (nonatomic, copy) NSString *lastModifiedDateTime;

@property (nonatomic, assign) NSNumber *shopId;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, assign) NSNumber *createdId;

@property (nonatomic, assign) NSNumber *operateId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) FMBrandExtraModel *extra;

@end


@interface FMBrandModel : NSObject

@property (nonatomic, assign) NSNumber *num;

@property (nonatomic, assign) NSNumber *collect;

@property (nonatomic, strong) FMBrandInfoModel *brandInfoEntity;

@property (nonatomic, copy) NSArray<FMHomeGoodsModel *> *goodsEntitys;

@end

/*
{
    "num":2,
    "brand":{
        "extra":{
            
        },
        "id":1,
        "backgroundUrl":"https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg",
        "createdDateTime":"",
        "details":"这是一个商品品牌",
        "logoUrl":"https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg",
        "code":"CB0001",
        "lastModifiedId":0,
        "lastModifiedDateTime":"",
        "dr":"N",
        "createdId":0,
        "shopId":18,
        "operateId":244,
        "name":"Goodbaby/好孩子",
        "status":"Y"
    },
    "collect":2,
    "goodsModel":[
                  {
                      "id":16,
                      "normalPrice":213123,
                      "url":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                      "activityType":"bargain",
                      "activityId":1,
                      "retailPrice":100,
                      "stock":100,
                      "bargainDiscount":1,
                      "num":200,
                      "promotionDiscount":2,
                      "name":"奶粉",
                      "promotionMax":8
                  },
                  {
                      "id":17,
                      "normalPrice":8,
                      "url":"http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                      "activityType":"bargain",
                      "activityId":1,
                      "retailPrice":100,
                      "stock":100,
                      "bargainDiscount":1,
                      "num":200,
                      "promotionDiscount":2,
                      "name":"合成天下",
                      "promotionMax":8
                  }
                  ]
}
*/
