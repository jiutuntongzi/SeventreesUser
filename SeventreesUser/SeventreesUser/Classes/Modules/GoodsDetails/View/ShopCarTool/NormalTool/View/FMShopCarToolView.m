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
    
    [[self.viewModel.requestJoinCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            [SVProgressHUD showWithStatus:@""];
        } else {
            [SVProgressHUD dismissWithDelay:0.5f];
        }
    }];
    
    [self.viewModel.showHintSubject subscribeNext:^(NSString *status) {
//        @strongify(self);
        [SVProgressHUD showInfoWithStatus:status];
    }];
    
    [self.viewModel.refreshUISubject subscribeNext:^(NetworkResultModel *resultModel) {
//        @strongify(self);
        if ([resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showSuccessWithStatus:@"加入商品成功"];
        }
    }];
    
    
    [[_contactButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel.actionSubject sendNext:nil];
    }];
    
    [[_collectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.viewModel.actionSubject sendNext:nil];
    }];
    
    [[_shoppingButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.viewModel.actionSubject sendNext:nil];
    }];
    
    [[_joinButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
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
