//
//  FMStoreInfoViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

#import "FMStoreInfoModel.h"

@interface FMStoreInfoViewModel : FMViewModel

@property (nonatomic, strong) FMStoreInfoModel *storeModel;

@property (nonatomic, strong) RACSubject *nextActionSubject;

@end
