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

#pragma mark - System Functions

- (void)updateViewConstraints {
    _mainView.frame = self.view.bounds;
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = [[FMShoppingView alloc] init];
    [self.view addSubview:_mainView];
    
//    [_mainView.viewModel.requestDataCommand execute:nil];
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
        if (self->_mainView.viewModel.shoppingGoodsEntitys.count == 0) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            [SVProgressHUD showInfoWithStatus:@"购物车无商品，请添加！"];
            [SVProgressHUD dismissWithDelay:1.f];
        }
        BOOL isEdit = ! self->_isEdit;
        self.isEdit = isEdit;
        self->_mainView.viewModel.isEdit = isEdit;
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
    self.isEdit = _isEdit;
    
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

- (void)fm_refreshData {
    [_mainView.viewModel.requestDataCommand execute:nil];
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    NSString *title = @"编辑";
    if (isEdit) title = @"完成";
    self.navigationItem.rightBarButtonItem.title = title;
}

@end
