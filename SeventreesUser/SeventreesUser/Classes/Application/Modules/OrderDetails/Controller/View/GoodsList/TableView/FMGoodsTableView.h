//
//  FMGoodsTableView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMOrderDetailsModel.h"
//#import "FMGoodsTableViewModel.h"

#define         FMGoodsTableViewHeight        420.f

@interface FMGoodsTableView : FMView

/** 只取商品数组及尾部订单信息、头部标题的部分字段 */
@property (nonatomic, strong) FMOrderDetailsModel *orderDetailsEntity;

//@property (nonatomic, strong) FMGoodsTableViewModel *viewModel;

@end
