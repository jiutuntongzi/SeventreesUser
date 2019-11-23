//
//  FMBargainDetailsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMBargainDetailsModel.h"

@interface FMBargainDetailsViewModel : FMViewModel

@property (nonatomic, strong) NSNumber *activityId;

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, copy) FMBargainDetailsModel *bargainDetailsEntity;


@property (nonatomic, strong) NSNumber *skuId;

@property (nonatomic, strong) RACCommand *requestStartBargainCommand;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end

