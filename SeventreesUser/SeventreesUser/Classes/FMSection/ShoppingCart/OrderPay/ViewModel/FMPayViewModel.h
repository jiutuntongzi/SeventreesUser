//
//  FMPayViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMPayModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMPayViewModel : FMViewModel

@property (nonatomic, strong) FMPayModel *model;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

NS_ASSUME_NONNULL_END
