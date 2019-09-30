//
//  FMDefaultController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMDefaultController.h"
#import "FMDefaultView.h"

#import "FMNavSearchBarView.h"
#import "FMGoodsCollectionView.h"

@interface FMDefaultController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *viewModel;

@property (strong, nonatomic) FMGoodsCollectionView *goodsListView;

@property (nonatomic, strong) FMNavSearchBarView *searchBarView;

@end

@implementation FMDefaultController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(kStatusBarHeight + kFixedHeight);
    }];
    
    [_searchBarView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kStatusBarHeight);
        make.left.right.equalTo([UIApplication sharedApplication].keyWindow);
        make.height.equalTo(kFixedHeight);
    }];
    
    [_goodsListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(4.f);
        make.left.right.equalTo(self->_mainView);
        make.bottom.equalTo(-10.f);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    FMDefaultView *mainView = [[FMDefaultView alloc] init];
    _mainView = mainView;
    [self.view addSubview:mainView];
    mainView.cv_backColor(UIColor.cc_colorByHexString(@"#F7F7F7"));
    
    /// 顶部搜索栏
    FMNavSearchBarView *searchBarView = [[FMNavSearchBarView alloc] init];
    _searchBarView = searchBarView;
    [[UIApplication sharedApplication].keyWindow addSubview:searchBarView];
    searchBarView.alpha = 0.01f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        searchBarView.alpha = 1.f;
    });
    _searchBarView.prevPageCallback = ^{
        [UIView animateWithDuration:0.25f animations:^{
            searchBarView.cv_frameOf(kScreenWidth, searchBarView.origin.y, searchBarView.width, searchBarView.height);
            searchBarView.alpha = 0.01f;
        } completion:^(BOOL finished) {
            [searchBarView removeFromSuperview];
        }];
        
        [commonMgr.topViewController().navigationController popViewControllerAnimated:YES];
    };
    
    /// 商品列表
    FMGoodsCollectionView *goodsListView = [[FMGoodsCollectionView alloc] init];
    _goodsListView = goodsListView;
    [_mainView addSubview:goodsListView];
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"SEVEN TREES";
}

- (void)fm_refreshData {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - Lazyload

- (void)dealloc {
    [_searchBarView removeFromSuperview];
}

@end
