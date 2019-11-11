//
//  FMCouponSelectCellViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMCouponSelectModel.h"

@interface FMCouponSelectCellViewModel : FMViewModel

@property (nonatomic, strong) FMCouponSelectModel *couponEntity;

@property (nonatomic, strong) RACSubject *checkedActionSubject;

@end
