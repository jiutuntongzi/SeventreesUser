//
//  FMBargainTypeViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/22.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMBargainItemModel.h"

@interface FMBargainTypeViewModel : FMViewModel

@property (nonatomic, copy) NSArray<FMBargainItemModel *> *itemEntitys;

/** 请求参数：砍价活动类型 */
@property (nonatomic, copy) NSString *activityType;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

