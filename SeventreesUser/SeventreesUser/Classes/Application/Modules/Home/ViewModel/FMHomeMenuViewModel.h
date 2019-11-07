//
//  FMHomeMenuViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMHomeMenuModel.h"

@interface FMHomeMenuViewModel : FMViewModel

@property (nonatomic, strong) NSArray<FMHomeMenuModel *> *menuEntitys;

@property (nonatomic, strong) RACSubject *itemActionSubject;

@end

