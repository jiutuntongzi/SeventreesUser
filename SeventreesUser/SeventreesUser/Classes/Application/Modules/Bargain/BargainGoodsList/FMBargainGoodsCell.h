//
//  FMBargainGoodsCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMCategoryGoodsModel.h"

#define     FMBargainGoodsCellRowHeight     152.f

@interface FMBargainGoodsCell : FMTableViewCell

@property (nonatomic, strong) FMCategoryGoodsModel *goodsEntity;

@end

