//
//  FMDefaultView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMDefaultView.h"
#import "FMGoodsCollectionView.h"

@interface FMDefaultView ()

@property (nonatomic, strong) FMGoodsCollectionView *goodsListView;


@end

@implementation FMDefaultView

- (void)fm_setupSubviews {
    FMGoodsCollectionView *goodsListView = [[FMGoodsCollectionView alloc] init];
    _goodsListView = goodsListView;
    self.cv_addSubview(goodsListView);
}

- (void)fm_bindViewModel {
    
}

@end
