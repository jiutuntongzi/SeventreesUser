//
//  FMImageEyeListView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMImageEyeListView.h"
#import "FMImageEyeCell.h"

#import "YBImageBrowser.h"      // 图片浏览器

@interface FMImageEyeListView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) YBImageBrowser *browser;

@end

@implementation FMImageEyeListView

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
    _collectionView.backgroundColor = UIColor.cc_colorByHexString(@"#EEEEEE");
    //    _collectionView.contentOffset = CGPointMake(0, 0);
    //    _collectionView.contentSize = CGSizeMake(self.width, 0);
//    _collectionView.ccv_registerClass();
    
    [_collectionView registerClass:[FMImageEyeCell class] forCellWithReuseIdentifier:NSStringFromClass([FMImageEyeCell class])];
    [self addSubview:_collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    @weakify(self)
    [RACObserve(self.viewModel, pictureModels) subscribeNext:^(id x) {
        @strongify(self)
        //    NSMutableArray<NSString *> *previewPictures = [NSMutableArray array];
        NSMutableArray<YBIBImageData *> *dataSourceArray = [NSMutableArray array];
        for (FMImageEyeModel *pictureModel in self.viewModel.pictureModels) {
            //        [previewPictures addObject:pictureModel.imgurl];
            YBIBImageData *imageData = [YBIBImageData new];
            imageData.imageURL = [NSURL URLWithString:pictureModel.imgurl];
            [dataSourceArray addObject:imageData];
        }
        self->_browser.dataSourceArray = dataSourceArray;
        
        [self->_collectionView reloadData];
    }];
};

- (FMImageEyeListViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMImageEyeListViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; // 水流方向(横向)
    _flowLayout = flowLayout;
    
    /// itemCell 宽/高
    CGFloat itemWH = FMImageEyeCellSize; // 固定值
    //    CGFloat itemWidth = (kScreenWidth - 15.f * 2.f - (horItemCount - 1) * margin) / 4.0f; // 动态高度
    CGFloat horItemCount = 4.f; // 水平方向4张图片
    CGFloat horMargin = (kScreenWidth - (15.f * 2.f) - itemWH * horItemCount) / 3.f; // 计算横向间隔
    
    // 列间距）
    flowLayout.minimumInteritemSpacing = 0;
    // 行间距）
    flowLayout.minimumLineSpacing = horMargin;

    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
}

- (void)updateConstraints {
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.pictureModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMImageEyeCell *cell = FMImageEyeCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    FMImageEyeModel *pictureModel = self.viewModel.pictureModels[indexPath.row];
    cell.imgUrlString = pictureModel.imgurl;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    // 浏览图片指定当前索引
    self.browser.currentPage = indexPath.row;
    [self.browser show];
    
    [self.viewModel.selectItemSubject sendNext:self.viewModel.pictureModels[indexPath.row]];
}

- (YBImageBrowser *)browser {
    if (! _browser) {
        _browser = [[YBImageBrowser alloc] init];
    }
    return _browser;
}

@end
