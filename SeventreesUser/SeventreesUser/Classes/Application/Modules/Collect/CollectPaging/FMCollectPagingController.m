//
//  FMCollectPagingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectPagingController.h"
#import "MacroHeader.h"

#import "FMCollectGoodsListController.h"
#import "FMCollectBrandListController.h"

#define     kClassNameVCKey      @"classNameVCKey"
#define     kTitleKey            @"titleKey"

@interface FMCollectPagingController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSArray *pageItems;

@end

@implementation FMCollectPagingController

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

    [self setupNavbar];
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
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

- (void)setupNavbar {
    __weak typeof(self) weakSelf = self;
    
    self.navigationItem.title = @"我的收藏";
    
    UIBarButtonItem *returnItem = UIBarButtonItem.cbi_initWithImageStyleForTouchCallback(@"icon_navBack", 1, ^(UIBarButtonItem *leftItem) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    self.navigationItem.cni_leftBarButtonItem(returnItem);
}

#pragma mark - Lazyload

- (NSArray *)pageItems {
    if (! _pageItems) {
        _pageItems = @[
                       @{kClassNameVCKey : @"FMCollectGoodsListController", kTitleKey : @"商品"},
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
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.f, menu.height - 1.f, menu.width, 1.f)];
    bottomLineView.userInteractionEnabled = NO;
    bottomLineView.backgroundColor = UIColor.cc_colorByHexString(@"#E5E5E5");
    [menu insertSubview:bottomLineView atIndex:0];
    
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 10.f;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0.f, 0.f, self.view.width, kFixedHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    //    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0.f, kFixedHeight, self.view.width, self.view.height - kFixedHeight);
}

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
