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

@property (nonatomic, strong) FMOrderModel *orderEntity;

@property (nonatomic, strong) RACSubject *leftActionSubject;

@property (nonatomic, strong) RACSubject *rightActionSubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *nextVCSubject;


@property (nonatomic, strong) RACCommand *requestCancelCommand;

@property (nonatomic, strong) RACCommand *requestReceivingCommand;

@property (nonatomic, strong) RACCommand *requestGoPaymentCommand;

@property (nonatomic, strong) RACSubject *reloadDataSubject;

@end
