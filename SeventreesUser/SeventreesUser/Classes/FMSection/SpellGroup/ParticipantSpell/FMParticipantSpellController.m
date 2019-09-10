//
//  FMParticipantSpellController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMParticipantSpellController.h"

@interface FMParticipantSpellController ()

/** 再售23337件后恢复1212.8起 */
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;

@property (weak, nonatomic) IBOutlet UILabel *differLabel;

@property (weak, nonatomic) IBOutlet UIButton *inviteFriendButton;

@property (weak, nonatomic) IBOutlet UIButton *returnSpellButton;

@end

@implementation FMParticipantSpellController

#pragma mark - System Functions

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    /// 物流标签富文本颜色
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"仅剩1个名额，23:57:04.7后结束" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.f], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    if (string.length > 2) {
        [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:247/255.0 green:111/255.0 blue:111/255.0 alpha:1.0]} range:NSMakeRange(2, 1)]; // 2：位置， 1：名额数量的字符长度（不能写死）
    }
    _differLabel.attributedText = string;
}

- (void)fm_bindViewModel {
    _returnSpellButton.layer.cornerRadius = 5.f;
    _returnSpellButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _returnSpellButton.layer.borderWidth = 1.f;
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"SEVEN TREES";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"促销活动", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMSalesActivityController") alloc] init];
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
