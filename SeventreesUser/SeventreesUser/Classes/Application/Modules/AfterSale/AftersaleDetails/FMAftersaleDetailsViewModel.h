//
//  FMAftersaleDetailsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMAftersaleDetailsModel.h"

@interface FMAftersaleDetailsViewModel : FMViewModel

@property (nonatomic, strong, readonly) FMAftersaleDetailsModel *aftersalemodel;


@property (nonatomic, strong, readonly) RACSubject *refreshUISubject;

@property (nonatomic, strong, readonly) RACSubject *actionSubject;

@property (nonatomic, strong, readonly) RACCommand *requestDataCommand;

@end
