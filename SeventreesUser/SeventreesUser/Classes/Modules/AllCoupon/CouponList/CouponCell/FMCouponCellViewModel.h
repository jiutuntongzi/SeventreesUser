//
//  FMCouponCellViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMCouponModel.h"

@interface FMCouponCellViewModel : FMViewModel

@property (nonatomic, strong) FMCouponModel *couponEntity;

/** 请求参数：优惠卷id(voucherId) */
//@property (nonatomic, assign) NSInteger couponId;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end
