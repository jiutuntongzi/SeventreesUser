//
//  FMMenuBarView.m
//  TheWaistcoat
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMenuBarView.h"
#import "FMTagItemCell.h"

#import "ChainKit.h"

#pragma mark - UI

@interface FMMenuBarView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

#pragma mark - Data

@property (nonatomic, copy) void(^selectItemCallback)(NSDictionary *rowInfo);

@end

@implementation FMMenuBarView

#pragma mark - Interface Function

- (instancetype)initWithFrame:(CGRect)frame dataSources:(NSArray<NSDictionary *> *)dataSources didSelectItemHandler:(void(^)(NSDictionary *info))selectItemCallback
{
    FMMenuBarView *menuBarView = [self initWithFrame:frame];
    menuBarView.selectItemCallback = selectItemCallback;
    menuBarView.dataSources = dataSources;
    [self didSelectItemByIndex:0];
    return menuBarView;
}

- (void)didSelectItemByIndex:(NSUInteger)index {
    if (index >= _dataSources.count) return;
    
    [self configCellSelectedAtIndex:index];
    
    [_collectionView reloadData];

    if (_selectItemCallback) _selectItemCallback(self.dataSources[index]);
}

- (void)configCellSelectedAtIndex:(NSUInteger)index {
    for (NSMutableDictionary *tempInfo in self.dataSources) {
        tempInfo[@"isSelected"] = @(NO);
    }
    NSMutableDictionary *info = _dataSources[index];
    info[@"isSelected"] = @(YES);
}

- (void)setDataSources:(NSArray *)dataSources {
    _dataSources = dataSources;
    
    [_collectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupSubviews];
    
    NSLog(@"width == %f,  height == %f", self.bounds.size.width, self.bounds.size.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self setupCollectionViewFlowLayout];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = NO;
    //    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = UIColor.whiteColor;
    //    _collectionView.contentOffset = CGPointMake(0, 0);
    //    _collectionView.contentSize = CGSizeMake(self.width, 0);
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FMTagItemCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FMTagItemCell class])];
    [self addSubview:_collectionView];
    
    
};

- (void)setupCollectionViewFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; // 水流方向
    _flowLayout = flowLayout;
    CGFloat margin = 8.f;
    
    //最小两行之间的间距     （列间距）
    flowLayout.minimumInteritemSpacing = 0.f;
    //同一行相邻两个cell的最小间距 （行间距）
    flowLayout.minimumLineSpacing = margin;
    
    /// itemCell 宽/高
    CGFloat itemWidth = 85.f;
    CGFloat itemHeight = 30.f;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // 每组Cell四边的边距
    _flowLayout.sectionInset = UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f);
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTagItemCell *cell = FMTagItemCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    cell.info = self.dataSources[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    // 滚动到上一项的位置
    NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:indexPath.row ? indexPath.row - 1 : indexPath.row inSection:indexPath.section];
    [collectionView scrollToItemAtIndexPath:preIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self didSelectItemByIndex:indexPath.row];
}

@end
