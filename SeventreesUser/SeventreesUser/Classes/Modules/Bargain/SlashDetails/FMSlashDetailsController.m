//
//  FMSlashDetailsController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/7.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashDetailsController.h"

#import "FMSlashGoodsView.h"

#import "FMSlashPricesView.h"
#import "FMSlashScopeView.h"
#import "FMTitleView.h"

#import "FMSlashRecordListView.h"

@interface FMSlashDetailsController ()


@property (nonatomic, strong) FMSlashGoodsView *slashGoodsView;

@property (nonatomic, strong) FMSlashScopeView *slashScopeView;
@property (nonatomic, strong) FMSlashPricesView *slashPricesView;
@property (nonatomic, strong) FMTitleView *titleView;

@property (nonatomic, strong) FMSlashRecordListView *recordListView;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation FMSlashDetailsController

- (void)fm_addSubviews {
    _slashGoodsView = FMSlashGoodsView.cv_viewFromNibLoad();
    [_contentView addSubview:_slashGoodsView];
    
    if (_style == FMSlashDetailsControllerStyleSlashing) {
        _slashScopeView = FMSlashScopeView.cv_viewFromNibLoad();
        [_contentView addSubview:_slashScopeView];
        
    } else if (_style == FMSlashDetailsControllerStyleSlashSuccess) {
        _slashPricesView = FMSlashPricesView.cv_viewFromNibLoad();
        [_contentView addSubview:_slashPricesView];
        
    } else if (_style == FMSlashDetailsControllerStyleSlashFailure) {
        _titleView = FMTitleView.cv_viewFromNibLoad();
        [_contentView addSubview:_titleView];
        
        _titleView.leftTitle = @"失败原因：砍价超时未支付，系统自动取消";
        _titleView.rightTitle = nil;
    }
    
    _recordListView = FMSlashRecordListView.cv_viewFromNibLoad();
    [_contentView addSubview:_recordListView];
}

- (void)fm_makeConstraints {
    
    __block CGFloat offsetY = 0.f, spaceValue = 15.f;
    
    [_slashGoodsView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self->_contentView);
        make.height.equalTo(FMSlashGoodsViewHeight);
    }];
    
    __block CGFloat centerHeight = 0.f;
    offsetY += FMSlashGoodsViewHeight + spaceValue;
    
    if (_style == FMSlashDetailsControllerStyleSlashing) {
        centerHeight = FMSlashScopeViewHeight;
        [_slashScopeView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self->_contentView);
            make.height.equalTo(centerHeight);
        }];
        
    } else if (_style == FMSlashDetailsControllerStyleSlashSuccess) {
        centerHeight = FMSlashPricesViewHeight;
        [_slashPricesView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self->_contentView);
            make.height.equalTo(centerHeight);
        }];
        
    } else if (_style == FMSlashDetailsControllerStyleSlashFailure) {
        centerHeight = FMTitleView_height;
        [_titleView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(offsetY);
            make.left.right.equalTo(self->_contentView);
            make.height.equalTo(centerHeight);
        }];
        // 失败原因：砍价超时未支付，系统自动取消
    }
    
    offsetY += (centerHeight + spaceValue);
    [_recordListView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(offsetY);
        make.left.right.bottom.equalTo(self->_contentView);
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"砍价详情";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"Next", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[NSClassFromString(@"FMSlashFreeController") alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

@end
