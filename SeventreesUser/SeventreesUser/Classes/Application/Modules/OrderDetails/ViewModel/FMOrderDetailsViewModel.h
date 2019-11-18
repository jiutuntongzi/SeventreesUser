//
//  FMOrderDetailsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMOrderDetailsModel.h"

@interface FMOrderDetailsViewModel : FMViewModel

@property (nonatomic, strong) NSNumber *orderId;

@property (nonatomic, strong) FMOrderDetailsModel *orderDetailsEntity;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end
