//
//  FMRefundOrderCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMRefundOrderModel.h"

#define      FMRefundOrderCellRowHeight       148.f

@interface FMRefundOrderCell : FMTableViewCell

@property (nonatomic, strong) FMRefundOrderModel *refundEntity;

@end
