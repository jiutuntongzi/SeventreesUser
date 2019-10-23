//
//  FMBrandGoodsView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBrandGoodsView.h"
#import "FMStoreIntroView.h"
#import "ScrollerMenuView.h"
#import "FMGoodsCell.h"

@interface FMBrandGoodsView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) FMStoreIntroView *storeIntroView;

@property (nonatomic, strong) ScrollerMenuView *scrollerMenuView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation FMBrandGoodsView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMBrandGoodsViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMBrandGoodsViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {
    
    [self setupStoreIntroView];
    
    [self setupScrollerMenuView];
    [self setupCollectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupStoreIntroView {
    _storeIntroView = (FMStoreIntroView *)FMStoreIntroView.cv_viewFromNibLoad();
    self.cv_addSubview(_storeIntroView);
}

- (void)setupScrollerMenuView {
    _scrollerMenuView = [[ScrollerMenuView alloc] initWithFrame:CGRectMake(0.f, 268.f + 10.f, kScreenWidth, 44.f)];
    self.cv_addSubview(_scrollerMenuView);
}

- (void)setupCollectionView {
    UIColor *backColor = UIColor.cc_colorByRGBA(247.f, 247.f, 247.f, 1.f);
    self.cv_backColor(backColor);
    
    [self setupCollectionViewFlowLayout];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    self.cv_addSubview(_collectionView);
    
    _collectionView.dataSource = self;  // _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FMGoodsCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FMGoodsCell class])];
    _collectionView.cv_backColor(backColor);
    _collectionView.cs_showsVerticalScrollIndicator(NO);
}

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
    //    _flowLayout.sectionInset = UIEdgeInsetsMake(marginValue, marginValue, marginValue, marginValue);
    
    CGFloat margin = 8.f;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 水流方向
    //最小两行之间的间距     （列间距）
    _flowLayout.minimumInteritemSpacing = margin;
    //同一行相邻两个cell的最小间距 （行间距）
    _flowLayout.minimumLineSpacing = margin;
    
    /// itemCell 宽/高
    CGFloat itemWidth = (kScreenWidth - margin) * 0.5;
    CGFloat itemHeight = itemWidth;
    _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [self.viewModel.refreshUISubject subscribeNext:^(FMBrandModel *brandModel) {
        @strongify(self);
        DLog(@"刷新页面：brandModel == %@", brandModel);
        self->_storeIntroView.viewModel.brandInfoEntity = brandModel.brandInfoEntity;
        [self->_collectionView reloadData];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [_storeIntroView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(268.f);
    }];
    
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(268.f + 60.f);
        make.bottom.equalTo(self).offset(-2.f);
        make.left.right.equalTo(self);
    }];
//    [_collectionView reloadData];
    
    [super updateConstraints];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.brandModel.goodsEntitys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMGoodsCell *cell = FMGoodsCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    
    FMGoodsCellViewModel *viewModel = [[FMGoodsCellViewModel alloc] init];
    viewModel.goodsModel = self.viewModel.brandModel.goodsEntitys[indexPath.row];
    cell.viewModel = viewModel;
    
    @weakify(self)
    
    [cell.viewModel.addActionSubject subscribeNext:^(FMHomeGoodsModel *goodsEntity) {
        @strongify(self);
        [self.viewModel.shopCarVCSubject sendNext:goodsEntity.goodsId];
    }];
    
    [cell.viewModel.selectActionSubject subscribeNext:^(FMHomeGoodsModel *goodsEntity) {
        @strongify(self)
        [self.viewModel.goodsDetailsVCSubject sendNext:goodsEntity.goodsId];
    }];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//
//    DLog(@"indexPath == %@", indexPath);
//}

#pragma mark - Lazyload

- (FMBrandGoodsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMBrandGoodsViewModel alloc] init];
    }
    return _viewModel;
}

@end
