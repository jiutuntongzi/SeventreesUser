//
//  FMBargainDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/7.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainDetailsController.h"

@interface FMBargainDetailsController ()

@property (weak, nonatomic) IBOutlet UIButton *selectBoxButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation FMBargainDetailsController

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"砍价详情";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_bindViewModel {
    [[_selectBoxButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    
    [[_startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

@end
