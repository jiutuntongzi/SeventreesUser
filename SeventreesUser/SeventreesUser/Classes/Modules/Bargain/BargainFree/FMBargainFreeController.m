//
//  FMBargainFreeController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/7.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainFreeController.h"

@interface FMBargainFreeController ()

@end

@implementation FMBargainFreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"砍价免费拿";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMBargainFreeController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

@end
