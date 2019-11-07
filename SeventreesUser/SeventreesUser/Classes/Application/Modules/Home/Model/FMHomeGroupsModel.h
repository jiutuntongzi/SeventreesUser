//
//  FMHomeGroupsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"
#import "FMHomeGoodsModel.h"

@interface FMHomeGroupsModel : FMModel

/** 分组图片 */
@property (nonatomic, copy) NSString *picUrl;

/** 分组商品列表 */
@property (nonatomic, copy) NSArray<FMHomeGoodsModel *> *goodsModels;

@end
