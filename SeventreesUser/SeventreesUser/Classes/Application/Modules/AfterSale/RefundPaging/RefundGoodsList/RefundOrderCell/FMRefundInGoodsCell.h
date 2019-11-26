//
//  FMRefundInGoodsCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMRefundGoodsModel.h"

#define    FMRefundInGoodsCellRowHeight    88.f;

@interface FMRefundInGoodsCell : FMTableViewCell

@property (nonatomic, strong) FMRefundGoodsModel *goodsEntity;

@end

