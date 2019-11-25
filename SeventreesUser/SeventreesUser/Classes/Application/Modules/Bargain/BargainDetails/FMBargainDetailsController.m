//
//  FMBargainDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/7.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainDetailsController.h"
#import "FMBargainDetailsViewModel.h"

#import "FMSlashDetailsController.h"

@interface FMBargainDetailsController ()

@property (weak, nonatomic) IBOutlet UILabel *bargainStatusLabel;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectBoxButton;
@property (weak, nonatomic) IBOutlet UIButton *startBargainButton;

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
        DLog(@"点了商品SKU");
    }];
    
    [[_startBargainButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.requestStartBargainCommand execute:nil];
    }];
    
    [self.viewModel.nextVCSubject subscribeNext:^(RACTuple *identifyTuple) {
        @strongify(self)
        [FMSlashDetailsController showByPageType:FMSlashDetailsControllerStyleSlashing activityId:self.viewModel.activityId goodsId:self.viewModel.goodsId];
    }];
    
    [UIView showRequestHUDStatus:@"发起砍价中.." command:self.viewModel.requestStartBargainCommand];
    [UIView showStatusInfoBySubject:self.viewModel.showHintSubject];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"发起砍价";
}

- (void)fm_refreshData {
    [self.viewModel.requestDataCommand execute:nil];
}

@end
