//
//  FMAftersaleGoodsCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMRefundGoodsModel.h"

#define      FMAftersaleGoodsCell_height      100.f

@interface FMAftersaleGoodsCell : FMTableViewCell

@property (nonatomic, strong) FMRefundGoodsModel *goodsEntity;

@end
