//
//  FMBargainTypeController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainTypeController.h"
#import "MacroHeader.h"
#import "FMBargainTypeViewModel.h"

#import "FMBargainGoodsListController.h"

//typedef NS_ENUM(NSUInteger, FMItemPageType) {
//    FMItemPageTypeDefault,
//    FMItemPageTypeCollect,
//    FMItemPageTypeSales,
//    FMItemPageTypePrice
//};

@interface FMBargainTypeController ()

@property (nonatomic, strong) FMBargainTypeViewModel *viewModel;

@end

@implementation FMBargainTypeController

+ (void)showByActivityType:(NSString *)activityType {
    FMBargainTypeController *pagingController = [[self alloc] init];
    pagingController.hidesBottomBarWhenPushed = YES;
    pagingController.viewModel.activityType = activityType;
    [commonMgr.topViewController().navigationController pushViewController:pagingController animated:YES];
}

#pragma mark - System Functions

- (instancetype)init {
    if (self = [super init]) {
        [self configTypeMenu];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    [self.viewModel.refreshUISubject subscribeNext:^(id obj) {
        @strongify(self)
        [self reloadData];
        
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:1.0f];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupNavbar];
    
    [self.viewModel.requestDataCommand execute:nil];
}

#pragma mark - Private Functions

/** 分类菜单配置 */
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

- (void)setupNavbar {
    self.navigationItem.title = @"砍到爽";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMBargainDetailsController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (FMBargainTypeViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMBargainTypeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - <WMPageControllerDelegate, WMPageControllerDataSource>

- (void)pageController:(WMPageController *)pageController willEnterViewController:(nonnull __kindof UIViewController *)viewController withInfo:(nonnull NSDictionary *)info {
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.viewModel.itemEntitys.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [self.viewModel.itemEntitys objectAtIndex:index].name;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    FMBargainGoodsListController *childController = [[FMBargainGoodsListController alloc] init];
    childController.categoryId = self.viewModel.itemEntitys[index].categoryId;
    childController.activityType = self.viewModel.activityType;
    return childController;
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
