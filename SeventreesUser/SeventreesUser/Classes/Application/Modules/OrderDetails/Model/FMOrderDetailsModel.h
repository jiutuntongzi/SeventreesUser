//
//  FMOrderDetailsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMGoodsInDetailModel.h"
#import "FMOrderPriceModel.h"
#import "FMOrderExplainModel.h"

@interface FMOrderDetailsModel : FMModel

@property (nonatomic, strong) NSNumber *orderId;

/** 订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）*/
@property (nonatomic, strong) NSNumber *orderStatus;

@property (nonatomic, strong) NSNumber *remainTime;


@property (nonatomic, strong) NSString *addressUserName;

@property (nonatomic, strong) NSString *addressMobile;

@property (nonatomic, strong) NSString *addressName;


@property (nonatomic, copy) NSArray<FMGoodsInDetailModel *> *goodsEntitys;

#pragma mark ——— 订单价格

/* 自定义的订单价格实体 **/
@property (nonatomic, strong) FMOrderPriceModel *orderPriceEntity;

@property (nonatomic, strong) NSNumber *goodsMoney;

@property (nonatomic, strong) NSNumber *expressAmount;

@property (nonatomic, strong) NSNumber *knockMoney;

@property (nonatomic, strong) NSNumber *couponMoney;

@property (nonatomic, strong) NSNumber *integralMoney;

@property (nonatomic, strong) NSNumber *totalPrice;


#pragma mark ——— 订单说明

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, strong) NSString *createOrderTime;

@property (nonatomic, copy) NSString *storeName;

@property (nonatomic, copy) NSString *logisticsName;

@property (nonatomic, copy) NSString *logisticsCode;

/* 自定义的订单说明实体 **/
@property (nonatomic, strong) FMOrderExplainModel *orderExplainEntity;

@end

/*
{
    "poOrderDetailsModel": {
        "orderId": 2676,    --订单id
        "orderCode": "1568794293868",    --订单编号
        "orderStatus": 1,    --订单状态
        "remainTime": 91358767,    --支付剩余时间（毫秒）
        "addressName": "湖南1天心区长沙1波波天下城",     --地址
        "addressMobile": "18888888888",    --电话
        "addressUserName": "tom2",    --用户名
        "apiPmGoodsList": [
                           {
                               "goodsId": 16,
                               "goodsImage": "http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",--商品图片
                               "goodsName": "奶粉",    --商品名字
                               "goodsNum": 2,    --数量
                               "goodsPrice": 0.00    --价格
                           }
                           ],
        "goodsMoney": 0.00,    --商品价格
        "expressAmount": 0.00,    --运费
        "knockMoney": 0.00,    --立减
        "couponMoney": 0.00,    --优惠券
        "integralMoney": 0.00,    --积分
        "totalPrice": 0.00,    --订单金额
        "createOrderTime": "2019-09-18 16:11:33",    --下单时间
        "storeName": "门店名称1",    --门店名称
        "logisticsName": "13",    --物流名字
        "logisticsCode": "13"    --物流单号
    }
}
*/


