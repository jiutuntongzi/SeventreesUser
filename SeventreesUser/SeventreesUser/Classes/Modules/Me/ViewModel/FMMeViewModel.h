//
//  FMMeViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/1.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMMeModel.h"

@interface FMMeViewModel : FMViewModel

@property (nonatomic, strong) FMMeModel *profileEntity;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end

