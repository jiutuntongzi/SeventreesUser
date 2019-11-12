//
//  FMOrderViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMOrderModel.h"

@interface FMOrderViewModel : FMViewModel

@property (nonatomic, copy) NSArray<FMOrderModel *> *orderEntitys;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

