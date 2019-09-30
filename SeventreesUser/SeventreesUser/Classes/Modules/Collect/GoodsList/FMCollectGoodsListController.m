//
//  FMCollectGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectGoodsListController.h"
#import "FMGoodsCollectionView.h"

@interface FMCollectGoodsListController ()

@property (nonatomic, strong) FMGoodsCollectionView *goodsListView;

@end

@implementation FMCollectGoodsListController

- (void)fm_addSubviews {
    /// 商品列表
    FMGoodsCollectionView *goodsListView = [[FMGoodsCollectionView alloc] init];
    _goodsListView = goodsListView;
    [self.view addSubview:goodsListView];
}

- (void)fm_makeConstraints {
    [_goodsListView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)fm_setupNavbar {
    
}

- (void)fm_bindViewModel {
    
}

- (void)fm_refreshData {
    
}

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
