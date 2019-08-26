//
//  FMGoodsDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsController.h"

@interface FMGoodsDetailsController ()

@property (nonatomic, strong) UIView *mainView;


@end

@implementation FMGoodsDetailsController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateViewConstraints {
    _mainView.frame = self.view.bounds;
    //    [_mainView makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.view);
    //    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
//    _mainView = [[FMShoppingView alloc] init];
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    
    self.navigationItem.title = @"商品详情";
    
//    __weak typeof(self) weakSelf = self;
//    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"编辑", 1, ^(UIBarButtonItem *leftItem) {
//        weakSelf.navigationController.cnc_pushViewControllerDidAnimated([[NSClassFromString(@"FMPayController") alloc] init], YES);
//    });
//    self.navigationItem.cni_rightBarButtonItem(rightItem);
    
    //    self.navigationItem.rightBarButtonItem.title = @"";
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload

@end
