//
//  FMGoodsDetailsCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMGoodsDetailsCellViewModel.h"

#define     FMGoodsDetailsCellRowHeight      135.f

@interface FMGoodsDetailsCell : FMTableViewCell

@property (nonatomic, strong) FMGoodsDetailsCellViewModel *viewModel;

@end
