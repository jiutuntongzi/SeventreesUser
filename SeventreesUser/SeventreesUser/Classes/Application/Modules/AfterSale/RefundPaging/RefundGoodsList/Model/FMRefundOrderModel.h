//
//  FMRefundOrderModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMRefundGoodsModel.h"

@interface FMRefundOrderModel : FMModel

/** status --售后状态(0等待处理,1审核不通过,2审核通过（退货中未填写物流）,3审核通过（退款中/退货中已填写物流）,5退款成功,4商家已验收 */
@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, strong) NSNumber *refundId;

@property (nonatomic, copy) NSArray<FMRefundGoodsModel *> *goodsEntitys;

@end

/*
"response": {
    "data": [
             {
                 "extra": {},
                 "id": 408,   // --id
                 "dr": "N",
                 "status": 0,  //  --售后状态(0等待处理,1审核不通过,2审核通过（退货中未填写物流）,3审核通过（退款中/退货中已填写物流）,5退款成功,4商家已验收
                 "apiPmGoodsList": [
                                    {
                                        "goodsId": 16,
                                        "skuId": 1,
                                        "goodsImage": "http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                                        "goodsName": "奶粉",
                                        "goodsNum": 2
                                    }
                                    ]
             },
             ],
}
*/
