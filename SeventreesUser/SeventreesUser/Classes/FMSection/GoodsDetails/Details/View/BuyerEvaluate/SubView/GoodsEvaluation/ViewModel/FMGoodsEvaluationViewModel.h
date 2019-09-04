//
//  FMGoodsEvaluationViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@class FMGoodsEvaluationModel;

@interface FMGoodsEvaluationViewModel : FMViewModel

@property (nonatomic, strong) FMGoodsEvaluationModel *model;


@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *actionSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@end
