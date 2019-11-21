//
//  FMGoodsDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsController.h"
#import "FMGoodsDetailsView.h"
#import "FMGoodsDetailsViewModel.h"

#import "FMEvaluationController.h"
#import "FMBrandGoodsController.h"

@interface FMGoodsDetailsController ()

@property (nonatomic, strong) FMGoodsDetailsView *mainView;

@end

@implementation FMGoodsDetailsController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置导航栏不透明
    [self setupNavigationTranslucent:NO];
}

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];

    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    [self setupNavigationTranslucent:YES];
    
    _mainView = [[FMGoodsDetailsView alloc] initWithFrame:SCREEN_B];
    _mainView.backgroundColor = UIColor.redColor;
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [_mainView.viewModel.nextActionSubject subscribeNext:^(id x) {
        @strongify(self)
        FMEvaluationController *nextVC = [[FMEvaluationController alloc] init];
        nextVC.goodsId = self->_goodsId;
        self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
    
    [_mainView.viewModel.nextBrandVCSubject subscribeNext:^(NSNumber *brandId) {
        @strongify(self)
        FMBrandGoodsController *nextVC = [[FMBrandGoodsController alloc] init];
        nextVC.brandId = brandId;
        self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    }];
}

- (void)fm_setupNavbar {
//    [super fm_setupNavbar];
    
    self.navigationItem.title = @"商品详情";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(nil, 1, ^(UIBarButtonItem *rightItem) {
        weakSelf.navigationController.cnc_popViewControllerDidAnimated(YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);

    /// 导航栏左
     UIButton *customBackButton = UIButton.cb_button();
     customBackButton.cv_frameOf(0.f, 0.f, kNavBarHeight, kNavBarHeight);
     customBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     self.navigationItem.cni_leftBarButtonItem(UIBarButtonItem.cbi_initWithCustomView(customBackButton));
    
     customBackButton.cb_imageOfNamed(@"icon_shopCar_back").cc_setActionEventsCallback(UIControlEventTouchUpInside, ^(UIButton *button) {
         if ([weakSelf.navigationController popViewControllerAnimated:YES] == nil) {
             [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
     }
     });
    
    /// 导航栏右
    UIButton *customRightButton = UIButton.cb_button();
    customRightButton.cv_frameOf(0.f, 0.f, kNavBarHeight, kNavBarHeight);
    customRightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.cni_rightBarButtonItem(UIBarButtonItem.cbi_initWithCustomView(customRightButton));
    
    customRightButton.cb_imageOfNamed(@"icon_shopCar_share").cc_setActionEventsCallback(UIControlEventTouchUpInside, ^(UIButton *button) {
        if ([weakSelf.navigationController popViewControllerAnimated:YES] == nil) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

/** 设置导航栏(全/不)透明 */
- (void)setupNavigationTranslucent:(BOOL)isTranslucent {
    self.navigationController.navigationBar.translucent = isTranslucent;
    UIImage *image = isTranslucent ? [UIImage new] : nil;
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
//    self.extendedLayoutIncludesOpaqueBars = NO;
}

- (void)fm_refreshData {
    _mainView.viewModel.goodsId = self.goodsId;
    [_mainView.viewModel.requestDataCommand execute:self.goodsId];
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"%@ 商品详情VC销毁了", NSStringFromClass([self class]));
}

@end
