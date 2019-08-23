//
//  FMMenuController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/13.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMenuController.h"
#import "BaseNavigationController.h"
#import "FMTypePageController.h"


@interface FMMenuController ()

@end

@implementation FMMenuController

#pragma mark - System Functions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    FMTypePageController *nextVC = [[FMTypePageController alloc] init];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    UINavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:nextVC];
//    self.cvc_presentVCAnimatedCompletion(navigationController, YES, nil);
    self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    
}

- (void)fm_bindViewModel {
    
}

- (void)fm_setupNavbar {
    self.navigationItem.title = @"分类";
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload

@end
