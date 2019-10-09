//
//  FMLoginViewModel.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewModel.h"
#import "FMLoginModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMLoginViewModel : FMViewModel

//@property (nonatomic, copy) NSArray *dataSources;

@property (nonatomic, strong) FMLoginModel *loginModel;

@property (nonatomic, strong) RACSignal *loginEnableSignal;

@property (nonatomic, strong) RACSubject *loginSuccessSubject;

@property (nonatomic, strong) RACSubject *registerActionSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

NS_ASSUME_NONNULL_END
