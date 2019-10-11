//
//  FMLoginViewModel.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewModel.h"
#import "FMLoginModel.h"

@interface FMLoginViewModel : FMViewModel

@property (nonatomic, strong) FMLoginModel *loginModel;

@property (nonatomic, strong) RACSubject *registerActionSubject;

@property (nonatomic, strong) RACSubject *agreementActionSubject;

@property (nonatomic, strong) RACSignal *loginEnableSignal;

@property (nonatomic, strong) RACSubject *loginSuccessSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACCommand *requestVerifyCodeCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end
