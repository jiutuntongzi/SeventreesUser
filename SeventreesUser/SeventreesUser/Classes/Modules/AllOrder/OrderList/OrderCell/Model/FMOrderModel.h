//
//  FMOrderModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMGoodsInDetailModel.h"

@interface FMOrderModel : FMModel

@property (nonatomic, copy) NSArray<FMGoodsInDetailModel *> *goodsDetailModels;

@end

