//
//  FMCouponListViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMCouponModel.h"

@interface FMCouponListViewModel : FMViewModel

/** 请求参数：优惠卷状态 1 = 未领取, 2 = 未使用, 3 = 已使用 */
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSArray<FMCouponModel *> *couponEntitys;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end

