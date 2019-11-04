//
//  FMMeViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/1.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMMeModel.h"
#import "FMPersonalInfoModel.h"

@interface FMMeViewModel : FMViewModel

@property (nonatomic, strong) FMMeModel *profileEntity;

@property (nonatomic, copy) NSArray<FMPersonalInfoModel *> *profileItems;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) NSMutableDictionary *bodyUpdateParams;
@property (nonatomic, strong) RACCommand *requestUpdateDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

//@property (nonatomic, strong) RACSubject *refreshProfileUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *showAddressVCSubject;

@end

