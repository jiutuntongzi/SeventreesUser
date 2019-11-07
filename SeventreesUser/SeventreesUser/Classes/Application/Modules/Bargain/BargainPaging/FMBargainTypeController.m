//
//  FMBargainTypeController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainTypeController.h"

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

@interface FMBargainTypeController ()

@property (copy, nonatomic) NSArray<UIViewController *> *childControllers;
@property (copy, nonatomic) NSArray<NSString *> *itemTitles;
@property (nonatomic, copy) NSDictionary *configs;

@end

@implementation FMBargainTypeController

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

//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    self.tabBarController.tabBar.hidden = YES;
    
    [self setupNavbar];
    
    
    [self reloadData];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
//    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}

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

/** 配置子页VC */
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
//    NSString * const _returnImageName = @"icon_navBack";
//    UIButton *customButton = UIButton.cb_button();
//    customButton.cv_frameOf(0.f, 0.f, 40.f, 40.f);
//    customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    self.navigationItem.cni_leftBarButtonItem(UIBarButtonItem.cbi_initWithCustomView(customButton));
//    __weak typeof(self) weakSelf = self;
//    customButton.cb_setImageOfNamed(_returnImageName).cc_setActionEventsCallback(UIControlEventTouchUpInside, ^(UIButton *button) {
//        if ([weakSelf.navigationController popViewControllerAnimated:YES] == nil) {
//            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
//        }
//    });

    self.navigationItem.title = @"砍到爽";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMBargainDetailsController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)refreshData {
    
}

#pragma mark - Lazyload

- (NSDictionary *)itemInfoForPageType:(FMItemPageType)type {
    NSString *classNameVC = @"FMBargainGoodsListController";
    if (!_configs) {
        _configs = @{
                     @(FMItemPageTypeDefault) : @{
                             _itemPageTypeVCKey               : classNameVC,
                             _itemPageTypeTitleKey            : @"全部",
                             },
                     @(FMItemPageTypeCollect) : @{
                             _itemPageTypeVCKey               : classNameVC,
                             _itemPageTypeTitleKey            : @"进口奶粉",
                             },
                     @(FMItemPageTypeSales) : @{
                             _itemPageTypeVCKey               : classNameVC,
                             _itemPageTypeTitleKey            : @"尿裤纸巾",
                             },
                     @(FMItemPageTypePrice) : @{
                             _itemPageTypeVCKey               : classNameVC,
                             _itemPageTypeTitleKey            : @"喂养用品",
                             },
                     @(FMItemPageTypePrice) : @{
                             _itemPageTypeVCKey               : classNameVC,
                             _itemPageTypeTitleKey            : @"服饰棉品",
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
