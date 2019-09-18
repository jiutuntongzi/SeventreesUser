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

@property (nonatomic, strong) FMCouponModel *model;

@property (nonatomic, strong) RACSubject *actionSubject;

@end
