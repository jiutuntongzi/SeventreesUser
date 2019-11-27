//
//  FMAftersaleDetailsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

#import "FMRefundOrderModel.h"

#import "FMRefundExplainModel.h"

@interface FMAftersaleDetailsModel : FMRefundOrderModel

@property (nonatomic, copy) NSString *statusTime;
@property (nonatomic, strong) NSNumber *remainTime;

@property (nonatomic, strong) NSNumber *payType;

@property (nonatomic, copy) NSString *recipients;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;


/** 自定义属性(手动转换来的)：退款订单详细说明实体 */
@property (nonatomic, strong) FMRefundExplainModel *explainEntity;

@property (nonatomic, copy) NSString *reason;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, copy) NSString *createdDateTime;
@property (nonatomic, strong) NSNumber *serialNumber;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *logisticsCompany;

@end

/*
"response": {
    "extra": {},
    "id": 407,
    "dr": "N",
    "createdDateTime": "2019-10-15 16:03:28",    --申请时间
    "lastModifiedDateTime": "2019-10-15 16:03:28", --每个状态下的时间
    "serialNumber": 1571126608534,    --退款编号
    "amount": 100,    --退款金额/申请金额
    "status": 0,    --状态(0等待处理,1审核不通过,2审核通过（退货中未填写物流）,3审核通过（退款中/退货中已填写物流）,退款成功，4商家已验收)
    "address": "运达国际中心",    --收货地址
    "recipients": "刘丽",    --收货人
    "reason": "不想要了",    --退款原因
    "phone": "18727175441",    --收货人电话
    "district": "244560557177",    --快递单号
    "distribution": "圆通速递",    --物流公司
    "payType": 1,    --1微信 2 支付宝
    "apiPmGoodsList": [
                       {
                           "goodsId": 16,
                           "skuId": 1,
                           "goodsImage": "http://qiniu.shengmei1858.com/upload/20190920/b93bde98ae37421699eb80b73f7d9af0.png",
                           "goodsName": "奶粉",
                           "goodsNum": 2
                       }
                       ],
    "remainTime": -170128675
}
*/
