//
//  BaseNavigationController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (void)initialize {
    // 获取导航栏
    UINavigationBar *navBar = [UINavigationBar appearance];
    /// 导航栏背景图
    //    UIImage *img =  [UIImage imageNamed:@"nav_bg"];
    //    [navBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[[UIImage alloc] init]]; // 去阴影线
    [navBar setBarTintColor:UIColor.whiteColor]; // 背景色
    
    /// 导航栏标题富文本字体大小/颜色样式
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor darkTextColor];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.f];
    [navBar setTitleTextAttributes:attributes];
    
    /// 导航栏不透明
    navBar.barStyle = UIBarStyleDefault;   // UIBarStyleBlackTranslucent ;
    navBar.translucent = NO;    // NO
    
    navBar.tintColor = [UIColor darkTextColor]; // 导航栏白色
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/*
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
//        viewController.navigationItem.leftBarButtonItem = [self barButtonItemWithImageName:@"nav_back" title:nil action:@selector(backAction) left:YES];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)backAction {
    [self popViewControllerAnimated:YES];
}
*/

/** 定制的左右导航按钮 */
/*
- (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName title:(NSString *)title action:(SEL)action left:(BOOL)left {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(0.0f, 0.0f, 70.f, 44.f);
    if (left) { // 左边的
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else { // 右边的
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

*/

@end
