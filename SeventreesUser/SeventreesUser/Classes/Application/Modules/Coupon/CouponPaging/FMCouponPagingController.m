//
//  FMCouponPagingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponPagingController.h"
#import "FMCouponListController.h"

#define     kClassNameVCKey      @"classNameVCKey"
#define     kTitleKey            @"titleKey"

typedef NS_ENUM(NSUInteger, FMCouponPagingItemType) {
    FMCouponPagingItemTypeNoget = 1,        // 未领取(1)
    FMCouponPagingItemTypeNouser,           // 未使用(2)
    FMCouponPagingItemTypeUsed,             // 已使用(3)
};

@interface FMCouponPagingController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSArray *pageItems;

@end

@implementation FMCouponPagingController

#pragma mark - System Functions

- (instancetype)init {
    if (self = [super init]) {
        [self configTypeMenu];
        [self configSubPages];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupNavbar];
}

#pragma mark - Private Functions

/** 配置分类菜单栏 */
- (void)configTypeMenu {
    self.showOnNavigationBar = NO;     //在导航栏上展示
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
    self.navigationItem.title = @"全部券";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithImageStyleForTouchCallback(@"icon_coupon_rightItem", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMCouponSelectListController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
    
    UIBarButtonItem *returnItem = UIBarButtonItem.cbi_initWithImageStyleForTouchCallback(@"icon_navBack", 1, ^(UIBarButtonItem *leftItem) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    self.navigationItem.cni_leftBarButtonItem(returnItem);
}

#pragma mark - Lazyload

- (NSArray *)pageItems {
    if (! _pageItems) {
        NSString * const classNameVC = @"FMCouponListController";
        _pageItems = @[
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"未领取"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"未使用"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"已使用"},
                       ];
    }
    return _pageItems;
}

#pragma mark ——— <WMPageControllerDelegate, WMPageControllerDataSource>

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof FMCouponListController *)couponListVC withInfo:(NSDictionary *)info {
    couponListVC.viewModel.status = (FMCouponPagingItemType)self.selectIndex + 1;
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

@end
