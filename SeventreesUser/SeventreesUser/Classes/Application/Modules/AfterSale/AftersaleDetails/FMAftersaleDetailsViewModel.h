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

@property (nonatomic, strong, readwrite) NSNumber *refundId;

@property (nonatomic, strong) FMAftersaleDetailsModel *refundEntity;

@property (nonatomic, strong, readonly) RACCommand *requestDataCommand;

@property (nonatomic, strong, readonly) RACSubject *showHintSubject;

@end
