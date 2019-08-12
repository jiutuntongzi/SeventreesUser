//
//  MainTabBarController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "MainTabBarController.h"

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
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
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
                             _tabBarVCKey               : @"",
                             _tabBarTitleKey            : @"TabBar1",
                             _tabBarNormalImageKey      : @"icon_message_normal",
                             _tabBarSelectedImageKey    : @"icon_message_pressed",
                             },
                     @(MainTabBarType2) : @{
                             _tabBarVCKey               : @"",
                             _tabBarTitleKey            : @"TabBar2",
                             _tabBarNormalImageKey      : @"icon_contact_normal",
                             _tabBarSelectedImageKey    : @"icon_contact_pressed",
                             },
                      @(MainTabBarType3) : @{
                             _tabBarVCKey               : @"",
                             _tabBarTitleKey            : @"TabBar3",
                             _tabBarNormalImageKey      : @"icon_chatroom_normal",
                             _tabBarSelectedImageKey    : @"icon_chatroom_pressed",
                      },
                     @(MainTabBarType4) : @{
                             _tabBarVCKey               : @"",
                             _tabBarTitleKey            : @"TabBar4",
                             _tabBarNormalImageKey      : @"icon_setting_normal",
                             _tabBarSelectedImageKey    : @"icon_setting_pressed",
                             }
                     };
        
    }
    return _configs[@(type)];
}

@end
