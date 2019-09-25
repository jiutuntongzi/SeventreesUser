//
//  FMInputController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMInputController.h"

#import "FMInputView.h"
#import "FMInputViewModel.h"
#import "FMStoreListController.h"

@interface FMInputController ()

@property (nonatomic, strong) FMInputView *mainView;

@end

@implementation FMInputController

#pragma mark - System Functions

- (void)updateViewConstraints {
    [_mainView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    _mainView = (FMInputView *)FMInputView.cv_viewFromNibLoad();
    _mainView.viewModel.type = (FMInputViewType)_type; // 通用枚举类型
    [self.view addSubview:_mainView];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [_mainView.viewModel.nextPageSubject subscribeNext:^(id x) {
        @strongify(self)
        
        if (self->_type == FMInputControllerTypeBindPhone) {
            
            
        } else if (self->_type == FMInputControllerTypeModifyPassword) {
            
            
        } else if (self->_type == FMInputControllerTypeBindStore) {
            UIViewController *nextVC = [[FMStoreListController alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            
        } else {
            FMInputController *nextVC = [[FMInputController alloc] init];
            nextVC.type = FMInputControllerTypeBindPhone;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    NSString *title;
    if (_type == FMInputControllerTypeBindPhone) {
        title = @"绑定新手机号";
    } else if (_type == FMInputControllerTypeModifyPassword) {
        title = @"修改登录密码";
    } else if (_type == FMInputControllerTypeBindStore) {
        title = @"换绑门店";
    } else {
        title = @"修改手机号";
    }
    self.navigationItem.title = title;
}

- (void)fm_refreshData {
    
}

#pragma mark - Lazyload

- (void)dealloc {
    DLog(@"VC销毁了");
}

@end
