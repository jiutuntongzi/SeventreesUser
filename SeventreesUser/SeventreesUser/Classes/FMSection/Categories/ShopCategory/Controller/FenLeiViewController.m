//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

// Controllers
#import "FenLeiViewController.h"
#import "FMTypePageController.h"

// Models

#import "CatogeryModel.h"

// Views

#import "DCClassCategoryCell.h"
#import "DCBrandSortCell.h"
#import "DCBrandsSortHeadView.h"

// Vendors

// Categories

//#import "UIBarButtonItem+DCBarButtonItem.h"

// Others
#import "MacroHeader.h"

//#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define tableViewH  95

@interface FenLeiViewController () <UITableViewDelegate, UITableViewDataSource,
UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (strong , nonatomic)UITableView *tableView;

@property (strong , nonatomic)UICollectionView *collectionView;
@property (strong , nonatomic)UIView *topSearchView;
@property (strong , nonatomic)UIButton *searchButton;
@property (strong , nonatomic)UIButton *voiceButton;

@property (strong,nonatomic)CatogeryModel *categeryModel;

@property (nonatomic,strong)NSArray<CatogeryList *>* rightList;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";

@implementation FenLeiViewController

#pragma mark - LazyLoad

-(NSArray<CatogeryList *>*)rightList{
    if (!_rightList){
        _rightList = @[];
    }
    return _rightList;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, tableViewH, self.view.height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 5; //X
        layout.minimumLineSpacing = 10;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH + 5, 0, kScreenWidth - tableViewH - 10, self.view.height);
        // 注册Cell
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTab];
    
   // [self setUpData];
    
    [self laodData];
}

#pragma mark loadDagte
-(void)laodData {
    __weak typeof(self) weakSelf = self;
//    [SMApi getCategryList:^(CatogeryModel * _Nullable categery) {
//        weakSelf.categeryModel = categery;
//        [weakSelf setUpData];
//    }];
}

#pragma mark - initizlize
- (void)setUpTab {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 加载数据
- (void)setUpData
{
    [self.tableView reloadData];
    [self.collectionView reloadData];
    if (self.categeryModel.data.count>0){
        CatogeryData *d = self.categeryModel.data[0];
        self.rightList = d.list;
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}


#pragma mark - 设置导航条
- (void)setUpNav {
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"分页", 1, ^(UIBarButtonItem *leftItem) {
        FMTypePageController *nextVC = [[FMTypePageController alloc] init];
        [weakSelf.navigationController pushViewController:nextVC animated:YES];
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
    
    self.navigationItem.cni_title(@"商品分类");
}

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categeryModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = self.categeryModel.data[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatogeryData *cd = self.categeryModel.data[indexPath.row];
    self.rightList = cd.list;
    [self.collectionView reloadData];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _rightList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    CatogeryList *list = self.rightList[section];
    return list.brands.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DCBrandSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCBrandSortCellID forIndexPath:indexPath];
    CatogeryList *list = self.rightList[indexPath.section];

    Brand *brand = list.brands[indexPath.row];
    cell.subItem = brand;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
        CatogeryList *list = self.rightList[indexPath.section];
//        CatogeryBrand *brand = list.brands[indexPath.row];
        headerView.headTitle = list.name;
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - tableViewH - 10 - 10.f)/3, (kScreenWidth - tableViewH - 10 - 10.f)/3 + 25);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 50);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    Brand *brand = self.rightList[indexPath.section].brands[indexPath.row];
//    SMBrandDetailController *vc = [SMBrandDetailController new];
//    vc.brandModel = brand;
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
