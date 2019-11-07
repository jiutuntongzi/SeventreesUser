//
//  FMHomeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeView.h"

#import "FMSearchButtonView.h"
#import "SDCycleScrollView.h"
#import "FMAnnouncementView.h"
#import "FMMenuView.h"
#import "FMStoreView.h"
#import "FMGoodsView.h"

@interface FMHomeView () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UIView *searchContentView;
@property (nonatomic, weak) FMSearchButtonView *searchButtonView;

@property (weak, nonatomic) IBOutlet UIView *scrollerContentView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UIView *textScrollContentView;
@property (strong, nonatomic) FMAnnouncementView *announcementView;

@property (weak, nonatomic) IBOutlet UIView *menuContentView;
@property (strong, nonatomic) FMMenuView *menuView;

@property (weak, nonatomic) IBOutlet UIView *storeContentView;
@property (strong, nonatomic) FMStoreView *storeView;

@property (weak, nonatomic) IBOutlet UIView *goodsContentView;
@property (strong, nonatomic) FMGoodsView *goodsListView;

@end

@implementation FMHomeView

#pragma mark - Public Functions


#pragma mark - System Functions

- (void)updateConstraints {
    _searchButtonView.cv_frame(CGRectMake(15.f, 11.f, _searchContentView.bounds.size.width - 30.f, 38.f));
    
    [_cycleScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_scrollerContentView);
    }];
    
//    _textScrollView.cv_frame(_textScrollContentView.bounds);
    [_announcementView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self->_textScrollContentView);
        make.size.equalTo(self->_textScrollContentView);
    }];
    
    _menuView.cv_frame(_menuContentView.bounds);
    
    _storeView.cv_frame(_storeContentView.bounds);
    
//    _securityCodeInputView.cv_frame(_inputContentView2.bounds);
    _goodsListView.cv_frame(_goodsContentView.bounds);
    
    [super updateConstraints];
}

#pragma mark - Private Functions

- (void)fm_setupSubviews {

    @weakify(self)
    self.cv_addTouchEventCallback(^(UIView *view) {
        self_weak_.cv_endEditing();
    });
    
    /// 搜索栏
    FMSearchButtonView *searchButtonView = FMSearchButtonView.cv_viewFromNibLoad();
    _searchButtonView = searchButtonView;
    [_searchContentView addSubview:searchButtonView];
    
    /// 图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_scrollerContentView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholderIcon"]];
    _cycleScrollView = cycleScrollView;
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView.cv_backColorRGBA(249.f, 249.f, 249.f, 1.f);
    [_scrollerContentView addSubview:cycleScrollView];
    
    /// 公告跑马灯
    _announcementView = [[FMAnnouncementView alloc] initWithFrame:_textScrollContentView.bounds];
    [_textScrollContentView addSubview:_announcementView];
    
    /// 菜单s
    FMMenuView *menuView = FMMenuView.cv_viewFromNibLoad();
    _menuView = menuView;
    [_menuContentView addSubview:menuView];
    
    /// 店铺
    FMStoreView *storeView = FMStoreView.cv_viewFromNibLoad();
    _storeView = storeView;
    [_storeContentView addSubview:storeView];
    
    /// 商品列表
    FMGoodsView *goodsListView = FMGoodsView.cv_viewFromNibLoad();
    _goodsListView = goodsListView;
    [_goodsContentView addSubview:_goodsListView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    _mainScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self_weak_.viewModel.refreshSubject sendNext:nil];
    }];
    
    [self.viewModel.refreshSubject subscribeNext:^(id x) {
        @strongify(self)     if (!self) return;
        
        [self.viewModel.requestDataCommand execute:nil];
        
        [self->_announcementView.viewModel.requestDataCommand execute:nil];
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(FMHomeModel *homeModel) {
        @strongify(self)     if (!self) return;
        
        self->_cycleScrollView.imageURLStringsGroup = homeModel.pictureURLStrings;
        
        self->_menuView.viewModel.menuEntitys = homeModel.menuModels;
        
        self->_storeView.viewModel.storeModel = homeModel.storeModel;
        
        self->_goodsListView.viewModel.goodsGroupModels = homeModel.goodsGroupModels;
        
        [self->_mainScrollView.mj_header endRefreshing];
    }];
    
    /*
    [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"加载中.."];
        } else {
            [SVProgressHUD dismissWithDelay:0.5f];
        }
    }];
    */
    _searchButtonView.actionCallback = ^{
        DLog(@"点了搜索");
        [self_weak_.viewModel.nextActionSubject sendNext:@"FMSearchPagingController"];
    };
    
    [self->_menuView.viewModel.itemActionSubject subscribeNext:^(NSString *menuType) {
        @strongify(self)     if (!self) return;
        DLog(@"点了菜单：code == %@", menuType);
        if ([menuType isEqualToString:@"sr"]) {
            [self.viewModel.nextActionSubject sendNext:@"FMCouponPagingController"];
        } else if ([menuType isEqualToString:@"group"]) {
            
        } else if ([menuType isEqualToString:@"bargain"]) {
            
        } else if ([menuType isEqualToString:@"parcel"]) {
            
        } else {
            
        }
    }];
    
    [self->_storeView.viewModel.chatActionSubject subscribeNext:^(FMHomeStoreModel *storeModel) {
        DLog(@"点了店铺聊天：storeModel == %@", storeModel);
    }];
    
    
}

#pragma mark - Lazyload

- (FMHomeViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMHomeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"---点击了第%ld张图片", (long)index);

}

- (void)dealloc {
    
}

@end
