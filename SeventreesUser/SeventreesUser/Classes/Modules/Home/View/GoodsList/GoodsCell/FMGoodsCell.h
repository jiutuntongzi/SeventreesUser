//
//  FMGoodsCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCollectionViewCell.h"

#import "FMGoodsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMGoodsCell : FMCollectionViewCell

@property (nonatomic, strong) FMGoodsViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
