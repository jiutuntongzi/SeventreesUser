//
//  FMApplyRefundController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMApplyRefundController.h"
#import "FMRefundGoodsCell.h"
#import "FMImageEyeCell.h"

#import "BRStringPickerView.h"

#define      kContentFixedHeight       380.f

@interface FMApplyRefundController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightCons;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsListHeightCons;

@property (weak, nonatomic) IBOutlet UIButton *causeBoxButton;

@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation FMApplyRefundController

- (void)fm_addSubviews {
    _tableView.rowHeight = FMRefundGoodsCellHeight;
    _tableView.dataSource = self;
    
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[FMImageEyeCell class] forCellWithReuseIdentifier:NSStringFromClass([FMImageEyeCell class])];
    
    [self setupCollectionViewFlowLayout];
}

- (void)setupCollectionViewFlowLayout {
    // 每组Cell四边的边距
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; // 水流方向(横向)
    
    /// itemCell 宽/高
    CGFloat itemWH = FMImageEyeCellSize + 5.f; // 固定值
    _flowLayout.minimumInteritemSpacing = 0.f;
    // 行间距）
    _flowLayout.minimumLineSpacing = 10.f;
    _flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
}

- (void)fm_makeConstraints {
    
}

- (void)fm_bindViewModel {
    [[_causeBoxButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSArray *selectItems = @[@"退运费", @"大小/尺寸与商品描述不符", @"做工问题", @"质量问题", @"其他问题"];
        [BRStringPickerView showStringPickerWithTitle:@"退款原因选择" dataSource:selectItems defaultSelValue:nil isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectText, NSInteger selectIdx) {
            
        } cancelBlock:^{
            DLog(@"取消");
        }];
    }];
    
    [[_commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"申请退款/退货";
    
    // test
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
                UIViewController *nextVC = [[NSClassFromString(@"FMRefundPagingController") alloc] init];
                [self.navigationController pushViewController:nextVC animated:YES];
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

#define     testCount       3.f

- (void)fm_refreshData {
    // test
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_goodsListHeightCons.constant = FMRefundGoodsCellHeight * testCount;
        self->_contentHeightCons.constant = kContentFixedHeight + FMRefundGoodsCellHeight * testCount;
    });
}

#pragma mark - <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMRefundGoodsCell *cell = FMRefundGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return testCount;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMImageEyeCell *cell = FMImageEyeCell.ccc_cellReuseForCollectionViewIndexPath(collectionView, indexPath);
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DLog(@"indexPath == %@", indexPath);
}

@end
