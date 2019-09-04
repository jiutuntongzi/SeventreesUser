//
//  FMBuyerEvaluateViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@class FMBuyerEvaluateModel;

@interface FMBuyerEvaluateViewModel : FMViewModel

@property (nonatomic, strong) FMBuyerEvaluateModel *model;


@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *actionSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@end
