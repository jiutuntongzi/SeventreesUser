//
//  FMCollectGoodsListController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectGoodsListController.h"
#import "FMGoodsCollectionView.h"

#import "FMGoodsDetailsController.h"
#import "FMShoppingController.h"

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

- (void)fm_bindViewModel {
    @weakify(self)
    [_goodsListView.viewModel.selectItemSubject subscribeNext:^(NSNumber *goodsId) {
        @strongify(self)    if (!self) return;
        
        global_goodsDetailsPageStyle = FMGoodsDetailsPageStyleNormal;
        FMGoodsDetailsController *nextVC = [[FMGoodsDetailsController alloc] init];
        nextVC.goodsId = goodsId;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    [_goodsListView.viewModel.addShopCarSubject subscribeNext:^(NSNumber *goodsId) {
        @strongify(self)    if (!self) return;
        
        FMShoppingController *nextVC = [[FMShoppingController alloc] init];
        nextVC.goodsId = goodsId;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
}

- (void)fm_refreshData {
    [_goodsListView.viewModel.requestDataCommand execute:nil];
}

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
