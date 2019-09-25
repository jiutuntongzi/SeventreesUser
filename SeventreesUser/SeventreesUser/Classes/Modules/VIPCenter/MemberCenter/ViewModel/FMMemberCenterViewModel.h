//
//  FMMemberCenterViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMMemberCenterViewModel : FMViewModel

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) RACSubject *nextActionSubject;

@end
