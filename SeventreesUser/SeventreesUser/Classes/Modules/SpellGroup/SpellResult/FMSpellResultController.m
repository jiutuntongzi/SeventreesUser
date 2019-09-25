//
//  FMSpellResultController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSpellResultController.h"

@interface FMSpellResultController ()

@property (weak, nonatomic) IBOutlet UILabel *differLabel;

@property (weak, nonatomic) IBOutlet UIButton *inviteFriendButton;

@property (weak, nonatomic) IBOutlet UIButton *returnSpellButton;

@end

@implementation FMSpellResultController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    
}

- (void)fm_bindViewModel {
    _returnSpellButton.layer.cornerRadius = 5.f;
    _returnSpellButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _returnSpellButton.layer.borderWidth = 1.f;
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"品牌商品";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMParticipantSpellController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
