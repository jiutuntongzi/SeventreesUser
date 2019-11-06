//
//  FMShopCarToolView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShopCarToolView.h"

const CGFloat FMShopCarToolViewHeight = 44.f;

@interface FMShopCarToolView ()

@property (weak, nonatomic) IBOutlet UIButton *contactButton;

@property (weak, nonatomic) IBOutlet UIImageView *collectImgView;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *shoppingButton;

@property (weak, nonatomic) IBOutlet UIButton *joinButton;

@property (weak, nonatomic) IBOutlet UIButton *buyItNowButton;

@end

@implementation FMShopCarToolView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

//- (void)setViewModel:(FMShopCarToolViewModel *)viewModel {
//    _viewModel = viewModel;
//    
//    
//}
//
//- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
//    _viewModel = (FMShopCarToolViewModel *)_viewModel;
//    
//    return [super initWithViewModel:viewModel];
//}

//- (void)fm_setupSubviews {
//
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
//}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [RACObserve(self.viewModel, isCollect) subscribeNext:^(NSNumber *isCollect) {
        self->_collectImgView.image = isCollect.boolValue ? UIImage.ci_imageNamed(@"icon_collect_selected") : UIImage.ci_imageNamed(@"icon_collect_normal");
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
    }];
    
    [[self.viewModel.requestCollectCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"收藏中.."];
        } else {
            [SVProgressHUD dismissWithDelay:0.15f];
        }
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
        self->_collectImgView.image = self.viewModel.isCollect ? UIImage.ci_imageNamed(@"icon_collect_selected") : UIImage.ci_imageNamed(@"icon_collect_normal");
    }];
    
    [[self.viewModel.requestJoinCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"加入中.."];
        } else {
            [SVProgressHUD dismissWithDelay:0.5f];
        }
    }];
    
    [[_contactButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel.actionSubject sendNext:nil];
    }];
    
    [[_collectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (![self.viewModel checkOKRequestCollectParams]) return;
        [self.viewModel.requestCollectCommand execute:nil];
    }];
    
    [[_shoppingButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.actionSubject sendNext:nil];
    }];
    
    [[_joinButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if ([self.viewModel checkOKRequestParams] == NO) return ;
        
        [self.viewModel.requestJoinCommand execute:nil];
    }];
    
    [[_buyItNowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel.actionSubject sendNext:nil];
    }];
}

#pragma mark - Lazyload

- (FMShopCarToolViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMShopCarToolViewModel alloc] init];
    }
    return _viewModel;
}


@end
