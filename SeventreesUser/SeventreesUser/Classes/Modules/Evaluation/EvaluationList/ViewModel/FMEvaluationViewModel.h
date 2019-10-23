//
//  FMEvaluationViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMGoodsDetailsModel.h"

@interface FMEvaluationViewModel : FMViewModel

/** 用户评价列表 */
@property (nonatomic, copy) NSArray<FMGoodsDetailsCommentsModel *> *commentsModels;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

