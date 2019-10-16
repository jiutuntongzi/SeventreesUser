//
//  FMSearchPagingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSearchPagingController.h"
#import "FMNavSearchBarView.h"
#import "MacroHeader.h"

#import "FMSearchGoodsListController.h"
#import "FMCollectBrandListController.h"

#define     kClassNameVCKey      @"classNameVCKey"
#define     kTitleKey            @"titleKey"

@interface FMSearchPagingController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSArray *pageItems;

@property (nonatomic, strong) FMNavSearchBarView *searchBarView;

@end

@implementation FMSearchPagingController

#pragma mark - System Functions

- (instancetype)init {
    if (self = [super init]) {
        [self configTypeMenu];
        [self configSubPages];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setupCustomNavigationBar];
    
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Private Functions

/** 配置分类菜单栏 */
- (void)configTypeMenu {
    self.showOnNavigationBar = NO;   
    self.automaticallyCalculatesItemWidths = YES;
    
    self.menuViewStyle = WMMenuViewStyleLine;
    self.scrollEnable = YES;
    self.titleSizeSelected = 15.f;
    self.titleSizeNormal = 15.f;
    UIColor *selectedColor = UIColor.cc_colorByHexString(@"#F76F6F");
    self.progressColor = selectedColor;
    self.titleColorSelected = selectedColor;
    self.titleColorNormal = UIColor.cc_colorByHexString(@"#333333");
    self.itemMargin = 10.f;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
}

/** 配置分类菜单栏 */
- (void)configSubPages {
    NSMutableArray *mChildControllers = [[NSMutableArray alloc] initWithCapacity:4];
    NSMutableArray *mTitles = [[NSMutableArray alloc] initWithCapacity:4];
    for (UInt8 i = 0 ; i < self.pageItems.count; i++) {
        NSDictionary *pageItem = self.pageItems[i];
        
        NSString *classNameVC = pageItem[kClassNameVCKey];
        UIViewController *childController = [[NSClassFromString(classNameVC) alloc] init];
        [mChildControllers addObject:childController];
        
        NSString *title = pageItem[kTitleKey];
        [mTitles addObject:title];
    }
    _childControllers = [mChildControllers copy];
    _itemTitles = [mTitles copy];
}

/** 自定义导航搜索栏 */
- (void)setupCustomNavigationBar {
    FMNavSearchBarView *searchBarView = [[FMNavSearchBarView alloc] init];
    _searchBarView = searchBarView;
    [self.view addSubview:searchBarView];
    searchBarView.alpha = 0.01f;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        searchBarView.alpha = 1.f;
    });
    __weak typeof(self) weakSelf = self;
    _searchBarView.prevPageCallback = ^{
        [UIView animateWithDuration:0.25f animations:^{
            searchBarView.cv_frameOf(kScreenWidth, searchBarView.origin.y, searchBarView.width, searchBarView.height);
            searchBarView.alpha = 0.01f;
        } completion:^(BOOL finished) {
            [searchBarView removeFromSuperview];
        }];
        [weakSelf.navigationController popViewControllerAnimated:YES];
//        [commonMgr.topViewController().navigationController popViewControllerAnimated:YES];
    };
    
    @weakify(self)
    _searchBarView.searchTouchCallback = ^(NSString *searchText) {
        UIViewController *currentViewController = self_weak_.currentViewController;
        if ([currentViewController isKindOfClass:[FMSearchGoodsListController class]]) {
            FMSearchGoodsListController *goodsListVC = (FMSearchGoodsListController *)self_weak_.currentViewController;
            goodsListVC.searchText = searchText;
        }
    };
    
    [_searchBarView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kStatusBarHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(kFixedHeight);
    }];
}

- (void)refreshData {
    
}

#pragma mark - Lazyload

- (NSArray *)pageItems {
    if (! _pageItems) {
        _pageItems = @[
                       @{kClassNameVCKey : @"FMSearchGoodsListController", kTitleKey : @"商品"},
                       @{kClassNameVCKey : @"FMCollectBrandListController", kTitleKey : @"品牌"},
                       ];
    }
    return _pageItems;
}

#pragma mark ——— <WMPageControllerDelegate, WMPageControllerDataSource>

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.pageItems.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return _itemTitles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return _childControllers[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    /// 分隔线
    UIColor *backColor = UIColor.cc_colorByHexString(@"#EEEEEE");
    UIView *topSpaceView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, menu.width, 1.f)];
    topSpaceView.userInteractionEnabled = NO;
    topSpaceView.backgroundColor = backColor;
    [menu insertSubview:topSpaceView atIndex:0];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.f, menu.height - 1.f, menu.width, 1.f)];
    topSpaceView.userInteractionEnabled = NO;
    bottomLineView.backgroundColor = backColor;
    [menu insertSubview:bottomLineView atIndex:0];
    
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 10.f;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0.f, kNavBarHeight, self.view.width, kFixedHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0.f, kNavBarHeight + kFixedHeight, self.view.width, kScreenHeight - kNavBarHeight - kFixedHeight);
}

- (void)dealloc {
    DLog(@"分页VC销毁了");
}

@end
