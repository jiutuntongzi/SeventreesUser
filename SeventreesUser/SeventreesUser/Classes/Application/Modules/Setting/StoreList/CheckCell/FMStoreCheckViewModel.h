//
//  FMStoreCheckViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMStoreCheckModel.h"

@interface FMStoreCheckViewModel : FMViewModel

@property (nonatomic, strong) FMStoreCheckModel *storeEntity;


@property (nonatomic, strong) RACSubject *checkActionSubject;

@property (nonatomic, strong) RACSubject *telephoneActionSubject;

@property (nonatomic, strong) RACSubject *addressActionSubject;

@end
