//
//  FMStoreView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreView.h"

@interface FMStoreView ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImgView;
@property (weak, nonatomic) IBOutlet UILabel *guideNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *distanceNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;

@end

@implementation FMStoreView

- (void)fm_bindViewModel {
    @weakify(self)
    
    [RACObserve(self.viewModel, storeModel) subscribeNext:^(FMHomeStoreModel *storeModel) {
        @strongify(self)
        [self->_logoImgView sd_setImageWithURL:[NSURL URLWithString:storeModel.shopLogo]];
        self->_guideNameLabel.text = storeModel.guideName ?: @"--";
        self->_shopNameLabel.text = storeModel.shopName ?: @"--";
        NSString *distance = storeModel.distance.integerValue != -1 ? [NSString stringWithFormat:@" 距您%@公里", storeModel.distance] : @" 未知距离";
        [self->_distanceNameLabel setTitle:distance forState:UIControlStateNormal];
    }];

    [[_chatButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel.chatActionSubject sendNext:self.viewModel.storeModel];
    }];
}

- (FMStoreViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMStoreViewModel alloc] init];
    }
    return _viewModel;
}

@end
