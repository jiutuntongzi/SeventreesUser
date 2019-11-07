//
//  FMRefundPagingController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundPagingController.h"
#import "MacroHeader.h"

#define     kClassNameVCKey      @"classNameVCKey"
#define     kTitleKey            @"titleKey"

@interface FMRefundPagingController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSArray *pageItems;

@end

@implementation FMRefundPagingController

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

    [self setupUI];
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

- (void)setupUI {
    
}

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
    
    self.navigationItem.title = @"售后";
    
    UIBarButtonItem *returnItem = UIBarButtonItem.cbi_initWithImageStyleForTouchCallback(@"icon_navBack", 1, ^(UIBarButtonItem *leftItem) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
    self.navigationItem.cni_leftBarButtonItem(returnItem);
    
    // test
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
//        FMAftersaleDetailsController *nextVC = [[FMAftersaleDetailsController alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)refreshData {
    
}

#pragma mark - Lazyload

- (NSArray *)pageItems {
    if (! _pageItems) {
        NSString * const classNameVC = @"FMRefundGoodsListController";
        _pageItems = @[
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"退款"},
                       @{kClassNameVCKey : classNameVC, kTitleKey : @"退货"},
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
