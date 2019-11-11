//
//  FMCouponModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/18.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMCouponModel : FMModel

/** (自定义属性) 优惠卷状态 1 = 未领取, 2 = 未使用, 3 = 已使用 */
@property (nonatomic, assign) NSInteger status;


@property (nonatomic, strong) NSNumber *couponId;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSNumber *discount;

@property (nonatomic, strong) NSNumber *amount;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *remake;

@property (nonatomic, strong) NSNumber *applicable;

@property (nonatomic, copy) NSDictionary *extra;

@end

/*
{
    "code": "OK",
    "message": "操作成功",
    "response": {
        "data": [
                 {
                     "extra": {},
                     "id": 2,     -- 优惠卷ID
                     "dr": "N",
                     "name": "折扣券",    -- 优惠卷名
                     "type": "2",      -- 优惠卷类型（1 = 现金卷 2 = 折扣卷）
                     "discount": 9.80,   --优惠卷折扣
                     "amount": 8.00,       --优惠卷金额
                     "startTime": "2019-09-20 11:19:43", --有效时间
                     "endTime": "2019-09-29 11:19:43",  --失效时间
                     "remake": "折扣券",        --备注
                     "applicable": 98.00           --适用金额满XX可用
                 }
                 ]
    }
}
*/
