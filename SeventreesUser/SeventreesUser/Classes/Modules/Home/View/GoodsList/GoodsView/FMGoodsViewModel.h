//
//  FMGoodsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMHomeGroupsModel.h"

@interface FMGoodsViewModel : FMViewModel

/** 推荐商品分组 */
@property (nonatomic, copy) NSArray<FMHomeGroupsModel *> *goodsGroupModels;

@end
