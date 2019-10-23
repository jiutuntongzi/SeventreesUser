//
//  FMBrandGoodsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBrandGoodsController.h"
#import "FMBrandGoodsView.h"

#import "FMGoodsDetailsController.h"
#import "FMShoppingController.h"

@interface FMBrandGoodsController ()

@property (nonatomic, strong) FMBrandGoodsView *mainView;

@end

@implementation FMBrandGoodsController

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMBrandGoodsView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [_mainView.viewModel.goodsDetailsVCSubject subscribeNext:^(NSNumber *goodsId) {
        @strongify(self)
        global_goodsDetailsPageStyle = FMGoodsDetailsPageStyleNormal;
        FMGoodsDetailsController *nextVC = [[FMGoodsDetailsController alloc] init];
        nextVC.goodsId = goodsId;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    [_mainView.viewModel.shopCarVCSubject subscribeNext:^(NSNumber *goodsId) {
        @strongify(self)
        FMShoppingController *nextVC = [[FMShoppingController alloc] init];
        nextVC.goodsId = goodsId;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"品牌商品";
}

- (void)fm_refreshData {
    [_mainView.viewModel.requestDataCommand execute:self->_brandId];
}

#pragma mark - System Functions

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
