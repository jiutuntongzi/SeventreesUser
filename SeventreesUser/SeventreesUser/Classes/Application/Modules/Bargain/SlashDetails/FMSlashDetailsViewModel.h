//
//  FMSlashDetailsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMSlashDetailsModel.h"

@interface FMSlashDetailsViewModel : FMViewModel

@property (nonatomic, strong) NSNumber *activityId;

@property (nonatomic, strong) NSNumber *goodsId;


@property (nonatomic, strong) RACCommand *requestDataCommand;
@property (nonatomic, strong) FMSlashDetailsModel *slashEntity;

@property (nonatomic, strong) RACCommand *requestRecordsCommand;
@property (nonatomic, copy) NSArray *recordEntitys;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end

