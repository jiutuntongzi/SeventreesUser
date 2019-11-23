//
//  FMBargainDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/7.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainDetailsController.h"
#import "FMBargainDetailsViewModel.h"

@interface FMBargainDetailsController ()

@property (weak, nonatomic) IBOutlet UIButton *selectBoxButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, strong) FMBargainDetailsViewModel *viewModel;

@end

@implementation FMBargainDetailsController

+ (void)showByActivityId:(NSNumber *)activityId goodsId:(NSNumber *)goodsId {
    FMBargainDetailsController *nextVC = self.cvc_controller();
    nextVC.viewModel.activityId = activityId;
    nextVC.viewModel.goodsId = goodsId;
    commonMgr.topViewController().cvc_pushViewController(nextVC);
}

- (FMBargainDetailsViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMBargainDetailsViewModel alloc] init];
    }
    return _viewModel;
}

- (void)fm_addSubviews {
    
}

- (void)fm_makeConstraints {
    
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self.viewModel, bargainDetailsEntity) subscribeNext:^(FMBargainDetailsModel *bargainEntity) {
        @strongify(self)    if (!self) return;
        
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [[_selectBoxButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
    }];
    
    [[_startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.requestStartBargainCommand execute:nil];
    }];
    
    [[self.viewModel.requestStartBargainCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"发起砍价中.."];
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"砍价详情";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMBargainFreeController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

- (void)fm_refreshData {
    [self.viewModel.requestDataCommand execute:nil];
}

@end
