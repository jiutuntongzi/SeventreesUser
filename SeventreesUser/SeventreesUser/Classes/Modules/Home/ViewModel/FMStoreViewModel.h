//
//  FMStoreViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMHomeStoreModel.h"

@interface FMStoreViewModel : FMViewModel

@property (nonatomic, strong) FMHomeStoreModel *storeModel;

@property (nonatomic, strong) RACSubject *chatActionSubject;


@end

