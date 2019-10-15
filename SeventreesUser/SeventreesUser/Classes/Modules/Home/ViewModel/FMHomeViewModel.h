//
//  FMHomeViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMHomeModel.h"

@interface FMHomeViewModel : FMViewModel

@property (nonatomic, strong) FMHomeModel *homeModel;

@property (nonatomic, strong) RACCommand *requestDataCommand;
@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACCommand *requestAnnouncementDataCommand;
@property (nonatomic, strong) RACSubject *refreshAnnouncementUISubject;

@property (nonatomic, strong) RACSubject *nextActionSubject;

@end
