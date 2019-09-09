//
//  FMSalesActivityViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@class FMSalesActivityModel;

@interface FMSalesActivityViewModel : FMViewModel

@property (nonatomic, strong) FMSalesActivityModel *model;


@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *actionSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@end
