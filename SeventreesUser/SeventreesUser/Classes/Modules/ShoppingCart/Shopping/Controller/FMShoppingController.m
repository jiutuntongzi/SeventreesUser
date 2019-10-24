//
//  FMShoppingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingController.h"
#import "FMShoppingView.h"

#import "FMGoodsDetailsController.h"
#import "FMPayController.h"

@interface FMShoppingController ()

@property (assign, nonatomic) BOOL isEdit;

@property (nonatomic, strong) FMShoppingView *mainView;

@end

@implementation FMShoppingController

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    }
}

#pragma mark - System Functions

- (void)updateViewConstraints {
    _mainView.frame = self.view.bounds;
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMShoppingView alloc] init];
    [self.view addSubview:_mainView];
    
    [_mainView.viewModel.requestDataCommand execute:nil];
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
    
    [_mainView.viewModel.settleAccountsVCSubject subscribeNext:^(id x) {
        @strongify(self)
        FMPayController *nextVC = [[FMPayController alloc] init];
        // code..
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
}

- (void)fm_setupNavbar {
    
    self.navigationItem.title = @"购物车";
    
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"编辑", 1, ^(UIBarButtonItem *leftItem) {
        self.isEdit = ! self->_isEdit;
        self->_mainView.viewModel.isEdit = ! self->_isEdit;
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
    self.isEdit = NO;
    
    /*
    if (_mainView.viewModel.shoppingGoodsEntitys.count ) {
//        __weak typeof(self) weakSelf = self;
        UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"编辑", 1, ^(UIBarButtonItem *leftItem) {
            self.isEdit = ! self->_isEdit;
            self->_mainView.viewModel.isEdit = ! self->_isEdit;
        });
        self.navigationItem.cni_rightBarButtonItem(rightItem);
        self.isEdit = NO;
        
    } else {
        self.navigationItem.cni_rightBarButtonItem(nil);
    }
    */
}

@end
