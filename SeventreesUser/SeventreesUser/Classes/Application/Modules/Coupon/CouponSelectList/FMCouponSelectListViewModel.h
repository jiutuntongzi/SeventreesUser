//
//  FMCouponSelectListViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMCouponSelectModel.h"

@interface FMCouponSelectListViewModel : FMViewModel

/** 请求参数：优惠卷状态 1 = 未领取, 2 = 未使用, 3 = 已使用 */
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSArray<FMCouponSelectModel *> *couponEntitys;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *checkedSubject;

/** 外部接口：页面关闭时回调选中的优惠券实体 */
@property (nonatomic, strong) RACSubject *popVCSubject;

@end

