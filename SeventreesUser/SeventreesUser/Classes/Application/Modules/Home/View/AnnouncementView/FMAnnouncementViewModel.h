//
//  FMAnnouncementViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMAnnouncementModel.h"

@interface FMAnnouncementViewModel : FMViewModel

@property (nonatomic, strong) NSArray<FMAnnouncementModel *> *announcementModels;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

