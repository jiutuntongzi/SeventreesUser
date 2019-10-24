//
//  FMGoodsCollectionView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsCollectionView.h"
#import "FMGoodsCell.h"

@interface FMGoodsCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation FMGoodsCollectionView

/** 设置子views */
- (void)fm_setupSubviews {
    [self setupCollectionViewFlowLayout];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = NO;
//    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = UIColor.cc_colorByHexString(@"#F7F7F7");
//    _collectionView.contentOffset = CGPointMake(0, 0);
//    _collectionView.contentSize = CGSizeMake(self.width, 0);
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FMGoodsCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FMGoodsCell class])];
    [self addSubview:_collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    @weakify(self)
    [RACObserve(self.viewModel, goodsEntitys) subscribeNext:^(NSArray<FMHomeGoodsModel *> *goodsEntitys) {
        @strongify(self) if (!self) return;
        
        [self->_collectionView reloadData];
    }];
    
//    [self.viewModel.refreshUISubject subscribeNext:^(NSArray<FMHomeGoodsModel *> *goodsEntitys) {
//        @strongify(self)    if (!self) return;
//        
//    }];
};

- (FMGoodsCollectionViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMGoodsCollectionViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
    //    _flowLayout.sectionInset = UIEdgeInsetsMake(marginValue, marginValue, marginValue, marginValue);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 水流方向
    _flowLayout = flowLayout;
    CGFloat margin = 10.f;
    
    //最小两行之间的间距     （列间距）
    flowLayout.minimumInteritemSpacing = margin;
    //同一行相邻两个cell的最小间距 （行间距）
    flowLayout.minimumLineSpacing = margin;
    
    /// itemCell 宽/高
    CGFloat itemWidth = (kScreenWidth - margin) * 0.5;
    CGFloat itemHeight = itemWidth * 1.28f;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)updateConstraints {
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.goodsEntitys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMGoodsCell *cell = FMGoodsCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    
    FMGoodsCellViewModel *viewModel = [[FMGoodsCellViewModel alloc] init];
    viewModel.goodsModel = self.viewModel.goodsEntitys[indexPath.row];
    cell.viewModel = viewModel;
    
    @weakify(self)
    
    [cell.viewModel.addActionSubject subscribeNext:^(FMHomeGoodsModel *goodsModel) {
        @strongify(self);
        [self.viewModel.addShopCarSubject sendNext:goodsModel.goodsId];
    }];
    
    [cell.viewModel.selectActionSubject subscribeNext:^(FMHomeGoodsModel *goodsModel) {
        @strongify(self);
        [self.viewModel.selectItemSubject sendNext:goodsModel.goodsId];
    }];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    DLog(@"indexPath == %@", indexPath);
}

@end
