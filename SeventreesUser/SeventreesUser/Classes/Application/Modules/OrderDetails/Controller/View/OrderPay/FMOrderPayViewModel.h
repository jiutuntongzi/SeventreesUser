//
//  FMOrderPayViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMOrderPayViewModel : FMViewModel

/** UI status */
@property (nonatomic, strong) NSNumber *orderStatus;

@property (nonatomic, strong) RACSubject *showHintSubject;

/** Request Params */
@property (nonatomic, strong) NSNumber *orderId;

@property (nonatomic, strong) RACCommand *requestCancelCommand;

@property (nonatomic, strong) RACCommand *requestReceivingCommand;

@property (nonatomic, strong) RACSubject *reloadDataSubject;

@end
