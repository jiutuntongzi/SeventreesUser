//
//  FMGoodsEvaluationViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

#import "FMGoodsDetailsModel.h"

@interface FMGoodsEvaluationViewModel : FMViewModel

@property (nonatomic, strong) FMGoodsDetailsCommentsModel *commentsModel;

@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
