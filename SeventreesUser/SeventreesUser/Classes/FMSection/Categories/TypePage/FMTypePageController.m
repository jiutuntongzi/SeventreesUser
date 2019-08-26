//
//  FMTypePageController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTypePageController.h"
#import "MacroHeader.h"


static const NSUInteger _itemPageCount = 4;

static NSString * const _itemPageTypeVCKey = @"itemPageTypeVCKey";
static NSString * const _itemPageTypeTitleKey = @"temPageTypeTitleKey";

typedef NS_ENUM(NSUInteger, FMItemPageType) {
    FMItemPageTypeDefault,
    FMItemPageTypeCollect,
    FMItemPageTypeSales,
    FMItemPageTypePrice
};

@interface FMTypePageController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSDictionary *configs;

@end

@implementation FMTypePageController

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

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    [self reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)updateViewConstraints {
    
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)setupUI {
    
}

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
    for (UInt8 i = 0 ; i < _itemPageCount; i++) {
        NSDictionary *configItem = [self itemInfoForPageType:i];
        
        NSString *className = configItem[_itemPageTypeVCKey];
        UIViewController *childController = [[NSClassFromString(className) alloc] init];
        [mChildControllers addObject:childController];
        
        NSString *title = configItem[_itemPageTypeTitleKey];
        [mTitles addObject:title];
    }
    _childControllers = [mChildControllers copy];
    _itemTitles = [mTitles copy];
}

- (void)setupNavbar {
    NSString * const _returnImageName = @"icon_navBack";
    UIButton *customButton = UIButton.cb_button();
    customButton.cv_frameOf(0.f, 0.f, 40.f, 40.f);
    customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.cni_leftBarButtonItem(UIBarButtonItem.cbi_initWithCustomView(customButton));
    __weak typeof(self) weakSelf = self;
    customButton.cb_setImageOfNamed(_returnImageName).cc_setActionEventsCallback(UIControlEventTouchUpInside, ^(UIButton *button) {
        if ([weakSelf.navigationController popViewControllerAnimated:YES] == nil) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

- (void)refreshData {
    
}

#pragma mark - Lazyload

- (NSDictionary *)itemInfoForPageType:(FMItemPageType)type {
    if (!_configs) {
        _configs = @{
                     @(FMItemPageTypeDefault) : @{
                             _itemPageTypeVCKey               : @"FMDefaultController",
                             _itemPageTypeTitleKey            : @"默认",
                             },
                     @(FMItemPageTypeCollect) : @{
                             _itemPageTypeVCKey               : @"FMCollectController",
                             _itemPageTypeTitleKey            : @"收藏",
                             },
                     @(FMItemPageTypeSales) : @{
                             _itemPageTypeVCKey               : @"FMSalesController",
                             _itemPageTypeTitleKey            : @"销量",
                             },
                     @(FMItemPageTypePrice) : @{
                             _itemPageTypeVCKey               : @"FMPriceController",
                             _itemPageTypeTitleKey            : @"价格",
                             }
                     };
    }
    return _configs[@(type)];
}


#pragma mark ——— <WMPageControllerDelegate, WMPageControllerDataSource>

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return _itemPageCount;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    
     return _itemTitles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    return _childControllers[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20.f;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = [UIColor whiteColor];
    return CGRectMake(0.f, kStatusBarHeight + kFixedHeight, self.view.width, kFixedHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
//    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0.f, kFixedHeight, self.view.width, kScreenHeight - kFixedHeight);
}

@end
