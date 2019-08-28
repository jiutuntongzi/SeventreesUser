//
//  FMGoodsSectionCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsSectionCell.h"
#import "FMGoodsCell.h"
#import "MacroHeader.h"

@interface FMGoodsSectionCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation FMGoodsSectionCell

/** 设置子views */
- (void)fm_setupSubviews {

    _collectionView.dataSource = self;  // _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FMGoodsCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FMGoodsCell class])];
    
    [self setupCollectionViewFlowLayout];
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    
};

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
//    _flowLayout.sectionInset = UIEdgeInsetsMake(marginValue, marginValue, marginValue, marginValue);
    
    CGFloat margin = 12.f;
    
    //最小两行之间的间距     （列间距）
    _flowLayout.minimumInteritemSpacing = margin;
    //同一行相邻两个cell的最小间距 （行间距）
    _flowLayout.minimumLineSpacing = margin;
    
    /// itemCell 宽/高
    CGFloat itemWidth = (kScreenWidth - 15.f * 2.f - margin) * 0.5;
    CGFloat itemHeight = itemWidth * 1.42f;
    _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    // 已知Cell宽度、商品图宽、高 求出Cell等比高度
    // 没用 itemWidth * shopImageView.h / shopImageView.w
    //  [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 水流方向
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMGoodsCell *cell = FMGoodsCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//
//    DLog(@"indexPath == %@", indexPath);
//}


@end
