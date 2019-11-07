//
//  FMBuyerEvaluateViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMGoodsDetailsModel.h"

@interface FMBuyerEvaluateViewModel : FMViewModel

/** 评价详细 */
@property (nonatomic, strong) FMGoodsDetailsCommentsModel *commentsModel;
/** 评价总数 */
@property (nonatomic, assign) NSInteger commentsTotal;

@property (nonatomic, strong) RACSubject *nextActionSubject;

@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
