//
//  FMGoodsFooterView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMOrderPriceModel.h"

extern const CGFloat FMGoodsFooterViewHeight;

@interface FMGoodsFooterView : FMView

/* 自定义的订单价格实体 **/
@property (nonatomic, strong) FMOrderPriceModel *orderPriceEntity;

@end
