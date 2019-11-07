//
//  FMOrderCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMOrderCellViewModel.h"

#define      FMOrderCellRowHeight        260.f
#define      FMOrderCellHeaderHeight     44.f
#define      FMOrderCellFooterHeight    (44.f*2.f+10.f)

@interface FMOrderCell : FMTableViewCell

@property (nonatomic, strong) FMOrderCellViewModel *viewModel;

@end

