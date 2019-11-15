//
//  FMOrderPagingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderPagingController.h"
#import "MacroHeader.h"

#import "FMFragmentBarView.h"
#import "FMStoreConsumeController.h"

#import "FMOrderListController.h"
#include "FMOrderPagingType.h"


#define     kClassNameVCKey      @"classNameVCKey"
#define     kTitleKey            @"titleKey"

@interface FMOrderPagingController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSArray *pageItems;

@end

@implementation FMOrderPagingController

+ (void)showByType:(unsigned int)type fromController:(UIViewController *)fromVC {
    global_orderType = type;
    FMOrderPagingController *nextVC = [[FMOrderPagingController alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    fromVC.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
}

#pragma mark - System Functions

- (instancetype)init {
    if (self = [super init]) {
        [self configTypeMenu];
        [self configSubPages];
        self.selectIndex = global_orderType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIViewController *chiodVC = self.childControllers[self.selectIndex];
//    [chiodVC reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupNavbar];
    
    [self reloadData];
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
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
    __weak typeof(self) weakSelf = self;
    
    UIBarButtonItem *returnItem = UIBarButtonItem.cbi_initWithImageStyleForTouchCallback(@"icon_navBack", 1, ^(UIBarButtonItem *leftItem) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    self.navigationItem.cni_leftBarButtonItem(returnItem);
    
    FMFragmentBarView *fragmentBarView = (FMFragmentBarView *)FMFragmentBarView.cv_viewFromNibLoad();
    fragmentBarView.type = 0;
    fragmentBarView.frame = CGRectMake(0.f, 0.f, 200.f, 30.f);
    self.navigationItem.titleView = fragmentBarView;
    fragmentBarView.actionCallback = ^(UInt8 type) {
        if (type == 1) {
            FMStoreConsumeController *nextVC = [[FMStoreConsumeController alloc] init];
            weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, NO);
        }
    };
}

- (void)refreshData {
    
}

#pragma mark - Lazyload

- (NSArray *)pageItems {
    if (! _pageItems) {
        NSString * const classNameVC = @"FMOrderListController";
        _pageItems = @[
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"全部"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"待付款"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"待发货"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"待收货"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"待评价"}
                       ];
    }
    return _pageItems;
}

#pragma mark ——— <WMPageControllerDelegate, WMPageControllerDataSource>

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof FMOrderListController *)orderListController withInfo:(NSDictionary *)info {
    global_orderType = (enum FMOrderPagingType)self.selectIndex;
    [orderListController requestReloadData];
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
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.f, menu.height - 2.f, menu.width, 2.f)];
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

@end
