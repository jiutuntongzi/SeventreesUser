//
//  FMRegisterViewModel.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewModel.h"
#import "FMRegisterModel.h"

@interface FMRegisterViewModel : FMViewModel

@property (nonatomic, strong) FMRegisterModel *registerModel;

//@property (nonatomic, strong) RACSignal *registerEnableSignal;

@property (nonatomic, strong) RACSubject *nextActionSubject;

@property (nonatomic, strong) RACSubject *registerSuccessSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACCommand *requestVerifyCodeCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end
