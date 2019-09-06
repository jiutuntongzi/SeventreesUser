//
//  FMGoodsInfoView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#import "FMGoodsInfoViewModel.h"
#import "FMGoodsInfoModel.h"

extern const CGFloat FMGoodsInfoViewHeight;

@interface FMGoodsInfoView : FMView

@property (nonatomic, strong) FMGoodsInfoViewModel *viewModel;

@end
