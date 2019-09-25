//
//  FMOrderCellViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMOrderModel.h"

@interface FMOrderCellViewModel : FMViewModel

@property (nonatomic, strong) FMOrderModel *orderModel;

@property (nonatomic, strong) RACSubject *leftActionSubject;

@property (nonatomic, strong) RACSubject *rightActionSubject;

@end
