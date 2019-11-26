//
//  FMSlashInGoodsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCategoryGoodsModel.h"

@interface FMSlashInGoodsModel : FMCategoryGoodsModel

/** 砍价中 / 砍价成功 / 砍价失败 */
@property (nonatomic, assign) NSInteger slashStatus;

@end
