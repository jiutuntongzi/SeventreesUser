//
//  FMScoreViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMScoreRecordModel.h"

@interface FMScoreViewModel : FMViewModel

@property (nonatomic, strong) NSMutableArray<FMScoreRecordModel *> *scoreEntitys;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *nextActionSubject;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshRecordSubject;

@end
