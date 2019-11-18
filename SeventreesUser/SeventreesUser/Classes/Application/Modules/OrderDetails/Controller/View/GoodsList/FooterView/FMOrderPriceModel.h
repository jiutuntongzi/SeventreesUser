//
//  FMOrderPriceModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/18.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMOrderPriceModel : FMModel

@property (nonatomic, strong) NSNumber *goodsMoney;

@property (nonatomic, strong) NSNumber *expressAmount;

@property (nonatomic, strong) NSNumber *knockMoney;

@property (nonatomic, strong) NSNumber *couponMoney;

@property (nonatomic, strong) NSNumber *integralMoney;

@property (nonatomic, strong) NSNumber *totalPrice;

@end

/*
"goodsMoney": 0.00,    --商品价格
"expressAmount": 0.00,    --运费
"knockMoney": 0.00,    --立减
"couponMoney": 0.00,    --优惠券
"integralMoney": 0.00,    --积分
"totalPrice": 0.00,    --订单金额
*/
