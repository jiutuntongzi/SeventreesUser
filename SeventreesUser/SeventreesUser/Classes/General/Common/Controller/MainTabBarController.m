//
//  MainTabBarController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"

static const NSUInteger _itemCount = 4;

static NSString * const _tabBarVCKey = @"_tabBarVCKey";
static NSString * const _tabBarTitleKey = @"_tabBarTitleKey";
static NSString * const _tabBarNormalImageKey = @"_tabBarNormalImageKey";
static NSString * const _tabBarSelectedImageKey = @"_tabBarSelectedImageKey";

typedef NS_ENUM(NSUInteger, MainTabBarType) {
    MainTabBarType1,
    MainTabBarType2,
    MainTabBarType3,
    MainTabBarType4
};

@interface MainTabBarController ()

@property (nonatomic, copy) NSDictionary *configs;

@end

@implementation MainTabBarController

+ (instancetype)instance {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (![rootViewController isKindOfClass:[MainTabBarController class]]) return nil;
    return (MainTabBarController *)rootViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBarItems];
}

- (void)setupTabBarItems {
    NSMutableArray *childControllers = [[NSMutableArray alloc] init];
    for (NSUInteger idx = 0; idx != _itemCount; idx++) {
        NSDictionary *item = [self itemInfoForTabBarType:idx];
        NSString *className = item[_tabBarVCKey];
        NSString *title  = item[_tabBarTitleKey];
        NSString *normalImageName = item[_tabBarNormalImageKey];
        NSString *selectedImageName = item[_tabBarSelectedImageKey];
        Class clazz = NSClassFromString(className);
        UIViewController *controller = [[clazz alloc] init];
        controller.hidesBottomBarWhenPushed = NO;
        
        UINavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:controller];
        navigationController.tabBarItem = [self tabBarItemWithTitle:title normalImageName:normalImageName selectedImageName:selectedImageName];
        navigationController.tabBarItem.tag = idx;
        [childControllers addObject:navigationController];
    }
    self.viewControllers = [childControllers copy];
}

- (UITabBarItem *)tabBarItemWithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName {
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] init];
    tabBarItem.title = title;
    tabBarItem.image = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    /// item标题选中/未选中富文本色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    [tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12.f];
    [tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    return tabBarItem;
}

- (NSDictionary *)itemInfoForTabBarType:(MainTabBarType)type {
    if (!_configs) {
        _configs = @{
                     @(MainTabBarType1) : @{
                             _tabBarVCKey               : @"FMHomeController",
                             _tabBarTitleKey            : @"首页",
                             _tabBarNormalImageKey      : @"homebarItem_normal_icon",
                             _tabBarSelectedImageKey    : @"homebarItem_selected_icon",
                             },
                     @(MainTabBarType2) : @{
                             _tabBarVCKey               : @"FMMenuController",
                             _tabBarTitleKey            : @"分类",
                             _tabBarNormalImageKey      : @"menubarItem_normal_icon",
                             _tabBarSelectedImageKey    : @"menubarItem_selected_icon",
                             },
                      @(MainTabBarType3) : @{
                             _tabBarVCKey               : @"FMShoppingController",
                             _tabBarTitleKey            : @"购物车",
                             _tabBarNormalImageKey      : @"shoppingbarItem_normal_icon",
                             _tabBarSelectedImageKey    : @"shoppingbarItem_selected_icon",
                      },
                     @(MainTabBarType4) : @{
                             _tabBarVCKey               : @"FMMeController",
                             _tabBarTitleKey            : @"我的",
                             _tabBarNormalImageKey      : @"mebarItem_normal_icon",
                             _tabBarSelectedImageKey    : @"mebarItem_selected_icon",
                             }
                     };
        
    }
    return _configs[@(type)];
}

@end
