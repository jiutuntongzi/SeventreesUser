//
//  FMShopCarToolViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMShopCarToolModel.h"

@interface FMShopCarToolViewModel : FMViewModel

@property (nonatomic, assign) BOOL isCollect;

@property (nonatomic, strong) FMShopCarToolModel *goodsParamsEntity;

@property (nonatomic, strong) RACCommand *requestJoinCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACCommand *requestCollectCommand;

@property (nonatomic, strong) RACSubject *actionSubject;

- (BOOL)checkOKRequestParams;

- (BOOL)checkOKRequestCollectParams;

@end
