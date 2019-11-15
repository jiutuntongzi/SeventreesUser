//
//  FMOrderModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMGoodsInDetailModel.h"

@interface FMOrderModel : FMModel

/** 自定义属性：订单页面类型 */
@property (nonatomic, assign) NSNumber *pageType;

@property (nonatomic, strong) NSNumber *orderId;

@property (nonatomic, copy) NSString *orderCode;

@property (nonatomic, strong) NSNumber *orderStatus;

@property (nonatomic, strong) NSNumber *orderPrice;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSArray<FMGoodsInDetailModel *> *goodsDetailModels;

@end

/*
[
 {
     "orderId": 2676,            --订单id
     "orderCode": "1568794293868",        --订单编码
     "orderStatus": 1,            --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
     "createTime": "2019-09-18 16:11:33",    --订单时间
     "orderPrice": 0.00,            --订单金额
     "poOrderGoodsModelList": [ --商品信息
                               {
                                   "goodsId": 16,    --商品id
                                   "goodsImage": "http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png",--图片
                                   "goodsName": "奶粉",    --名字
                                   "goodsNum": 2,    --数量
                                   "goodsPrice": 0.00    --价格
                               }
                               ]
 }
]
*/
