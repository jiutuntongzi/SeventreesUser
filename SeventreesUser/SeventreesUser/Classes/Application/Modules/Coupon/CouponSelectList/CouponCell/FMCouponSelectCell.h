//
//  FMCouponSelectCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMCouponSelectCellViewModel.h"

#define         FMCouponSelectCellRowHeight       120.f

@interface FMCouponSelectCell : FMTableViewCell

@property (nonatomic, strong) FMCouponSelectCellViewModel *viewModel;

@end

