//
//  FMMeModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/1.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMMeModel : FMModel

@property (nonatomic, strong) NSNumber *userId;

@property (nonatomic, copy) NSDictionary *extra;

@property (nonatomic, copy) NSString *isAdmin;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, strong) NSNumber *couponNum;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, strong) NSNumber *commentsNum;

@property (nonatomic, strong) NSNumber *takeNum;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, strong) NSNumber *shopId;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, strong) NSNumber *integralNum;

@property (nonatomic, strong) NSNumber *paymentNum;

@property (nonatomic, strong) NSNumber *deliveryNum;

@end


/*
"extra": {},

"id": 7,    --userId

"shopId": 18,    --门店id

"isAdmin": "N",    --是否店长 y是n不是

"name": "六六",    -名称

"phone": "15575818241",    --电话

"sex": "1",    --性别1男 2女

"birthday": "2019-10-10",    --生日

"headUrl": "https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg", --头像

"nick": "隔壁老六",    --昵称

"couponNum": 0,        --优惠券数

"integralNum": 0,    --积分数

"paymentNum": 4,    --待支付
"deliveryNum": 1,    --待发货
"takeNum": 1,    --待取货
"commentsNum": 1    --待评论
*/
