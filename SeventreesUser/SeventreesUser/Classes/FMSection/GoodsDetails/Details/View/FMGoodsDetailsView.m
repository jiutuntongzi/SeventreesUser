//
//  FMGoodsDetailsView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsView.h"

#import "FMShopCarToolView.h"

#import "FMShopDetailView.h"
#import "FMStoreInfoView.h"
#import "FMGoodsPictureListView.h"
#import "FMBuyerEvaluateView.h"
#import "FMGoodsPictureListView.h"

@interface FMGoodsDetailsView ()

@property (nonatomic, strong) FMShopCarToolView *shopCarToolView;

@property (nonatomic, strong) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) FMShopDetailView *shopDetailView;

@property (nonatomic, strong) FMStoreInfoView *storeInfoView;

@property (nonatomic, strong) FMBuyerEvaluateView *evaluateView;

@property (nonatomic, strong) FMGoodsPictureListView *pictureListView;

@end

@implementation FMGoodsDetailsView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMGoodsDetailsViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMGoodsDetailsViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {
    
    [self setupMainScrollView];
    
    [self setupGoodsPictureView];
    
    [self setupStoreInfoView];
    
    [self setupBuyerEvaluateView];
    
    [self setupPictureListView];
    
//    [self addSubviewContents];
    
    [self setupShopCarToolView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupShopCarToolView {
    _shopCarToolView = (FMShopCarToolView *)FMShopCarToolView.cv_viewFromNibLoad();
    [self addSubview:_shopCarToolView];
}

/** 主Scroller */
- (void)setupMainScrollView {
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    mainScrollView.bounces = YES;
    mainScrollView.backgroundColor = UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f);
    mainScrollView.contentSize = CGSizeMake(0.f, 2000.f);
    mainScrollView.scrollEnabled = YES;
    _mainScrollView = mainScrollView;
    [self addSubview:_mainScrollView];
    
    UIView *contentView = [[UIView alloc] init];
    _contentView = contentView;
    [_mainScrollView addSubview:contentView];
}

/** 商品详情浏览 */
- (void)setupGoodsPictureView {
    _shopDetailView = [FMShopDetailView new];
    [_contentView addSubview:_shopDetailView];
}

/** 店铺信息 */
- (void)setupStoreInfoView {
    _storeInfoView = (FMStoreInfoView *)FMStoreInfoView.cv_viewFromNibLoad();
    [_contentView addSubview:_storeInfoView];
}

/** 用户评价 */
- (void)setupBuyerEvaluateView {
    _evaluateView = [FMBuyerEvaluateView new];
    [_contentView addSubview:_evaluateView];
}

/** 商品图片列表 */
- (void)setupPictureListView {
    _pictureListView = [FMGoodsPictureListView new];
    [_contentView addSubview:_pictureListView];
}

/** 添加ScrollView ContentView 的子视图 */
- (void)addSubviewContents {
//    _mainScrollView.cv_addSubviews(@[_shopDetailView, _storeInfoView]);
}

- (void)fm_bindViewModel {
    // code ..
}

#pragma mark - System Functions

- (void)updateConstraints {
    CGFloat contentVHeight = 2000.f; // test
    
    [_mainScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->_mainScrollView);
        make.width.equalTo(self.width);
        make.height.equalTo(contentVHeight);
    }];
    
    [_shopCarToolView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(FMShopCarToolViewHeight);
    }];
    
    
    /// subviewContents
    const CGFloat margin = 15.f;    CGFloat offsetY = 0.f;
    
    [_shopDetailView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMShopDetailViewHeight);
    }];
    
    offsetY += (FMShopDetailViewHeight + margin);
    [_storeInfoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_contentView).offset(FMShopDetailViewHeight + margin);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMStoreInfoViewHeight);
    }];
    
    offsetY += (FMStoreInfoViewHeight + margin);
    [_evaluateView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_contentView).offset(offsetY);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(FMBuyerEvaluateViewHeight);
    }];
    
    offsetY += (FMBuyerEvaluateViewHeight + margin);
    [_pictureListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_contentView).offset(offsetY);
        make.left.equalTo(self->_contentView);
        make.width.equalTo(self->_contentView);
        make.height.equalTo(1087.f );
    }];
    
    [super updateConstraints];
}


#pragma mark - Lazyload

- (FMGoodsDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMGoodsDetailsViewModel alloc] init];
    }
    return _viewModel;
}

@end
