//
//  FMSettingView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSettingView.h"
#import "FMSelectItemCell.h"
#import "FMInputController.h"

#import "DialogBoxView.h"

#define     kServiceTelephone       @"0731123142"
#define     kServiceTelText         @"07311-23142"

static const NSUInteger _rowCount = 8;

@interface FMSettingView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *selectItems;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat rowHeight;

@property (strong, nonatomic) UIButton *logoutButton;

@end

@implementation FMSettingView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (NSDictionary *)itemInfoForIndex:(NSUInteger)index {
    if (! _selectItems) {
        NSString * const controller = @"className";
        NSString * const title = @"title";
        NSString * const subTitle = @"subTitle";
        
        
        NSString *appVersionText = [NSString stringWithFormat:@"当前版本%@", [UIApplication sharedApplication].appVersion];

        
        _selectItems = @{
                     @(0) : @{
                             controller      : @"FMFeedbackController",
                             title           : @"意见反馈",
                             subTitle        : @"",
                             },
                     @(1) : @{
                             controller      : @"FMInputController",
                             title           : @"修改手机号",
                             subTitle        : @"",
                             },
                     @(2) : @{
                             controller      : @"FMInputController",
                             title           : @"修改登录密码",
                             subTitle        : @"",
                             },
                     @(3) : @{
                             controller      : @"FMInputController",
                             title           : @"换绑门店",
                             subTitle        : @"",
                             },
                     @(4) : @{
                             controller      : @"",
                             title           : @"清除缓存",
                             subTitle        : @"",
                             },
                     @(5) : @{
                             controller      : @"",
                             title           : @"检查版本",
                             subTitle        : appVersionText ?: @"",
                             },
                     @(6) : @{
                             controller      : @"",
                             title           : @"联系客服",
                             subTitle        : kServiceTelText,
                             },
                     @(7) : @{
                             controller      : @"FMAboutController",
                             title           : @"关于seventrees",
                             subTitle        : @"",
                             }
                     };
        
    }
    return _selectItems[@(index)];
}

- (void)fm_setupSubviews {
    _rowHeight = 44.f;
    self.cv_backColor(UIColor.whiteColor);
    
    [self setupTableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupTableView {
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    UITableView *tableView = UITableView.ct_tableViewWithFrameStyle(0.f, 0.f, width, height, UITableViewStylePlain)\
    .ct_dataSource(self).ct_delegate(self)\
    .ct_rowHeight(_rowHeight).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#EEEEEE"))\
    .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f)); // .ct_tableFooterView(UIView.cv_viewWithFrame(CGRectZero))
    tableView.cv_backColorByHexString(@"#F7F7F7");
    tableView.bounces = NO;
    self->_tableView = tableView;
    
//    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
////        [self->_pagingUtility execPullDownRefresh];
//    }];
//    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////        [self->_pagingUtility execUpPullLoad];
//    }];
    
    [self addSubview:tableView];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);

        [self.viewModel.logoutActionSubject sendNext:nil];
    }];
}

/**
 * 拨打电话，弹出提示，拨打完电话回到原来的应用
 *
 * @param telephone 电话号码字符串
 */
- (void)callTelephone1:(NSString *)telephone {
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", telephone]]]];
    [self addSubview:callWebview];
}

/**
 * 拨打电话，弹出提示，拨打完电话回到原来的应用
 * 注意这里是 telprompt://
 * @param telephone 电话号码字符串
 */
- (void)callTelephone:(NSString *)telephone {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",telephone]]];
}

/** SDWebImage 清理图片缓存 */
- (void)clearCacheTempPics {
    [DialogBoxView showByTitle:@"清除缓存" message:@"\n\n确认清空缓存？" affirmButtonTitle:@"清除" forStyle:DialogBoxViewStyleAffirm affirmHandler:^(NSString * _Nullable text) {
        [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeDisk completion:^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            [SVProgressHUD dismissWithDelay:0.5f];
        }];
    }];
    /*
    self.viewController.cvc_showAlertControllerByTitleDescrConfirmCompleted(@"清除缓存", @"确认清除缓存？", @"清除", ^{
        [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeDisk completion:^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            [SVProgressHUD dismissWithDelay:1.5f];
        }];
    });
    */
}

/** 检查版本 */
- (void)checkVersion {
    NSString *message = @"\n是否跳转至苹果应用商店(App Store)查看/安装最新版本？";
    [DialogBoxView showByTitle:@"新版本" message:message affirmButtonTitle:@"更新" forStyle:DialogBoxViewStyleAffirm affirmHandler:^(NSString * _Nullable text) {
        NSString *appId = @"1344037247";
        NSString *URLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id%@?mt=8", appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self); // make.left.right.top.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMSettingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSettingViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMSelectItemCell *cell = FMSelectItemCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.itemModel = [FMSelectItemModel modelWithDictionary:[self itemInfoForIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowCount;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"点了第%ld行", (long)indexPath.row);
    
    //         清除缓存       丨       检查版本      丨       联系客服
    if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6) {
        
        if (indexPath.row == 6) {
            [self callTelephone:kServiceTelephone];
            
        } else if (indexPath.row == 4) {
            [self clearCacheTempPics];
            
        } else if (indexPath.row == 5) {
            [self checkVersion];
        }
        return;
    }
    
    FMSelectItemModel *itemModel = [FMSelectItemModel modelWithDictionary:[self itemInfoForIndex:indexPath.row]];
    
    if (!itemModel.className.length) return;
    
    if ([itemModel.className isEqualToString:@"FMInputController"]) {
        FMInputController *inputVC = [[FMInputController alloc] init];
        if (indexPath.row == 1) {
            inputVC.type = FMInputControllerTypeModifyPhone;
        } else if (indexPath.row == 2) {
            inputVC.type = FMInputControllerTypeModifyPassword;
        } else if (indexPath.row == 3) {
            inputVC.type = FMInputControllerTypeBindStore;
        }
        [self.viewController.navigationController pushViewController:inputVC animated:YES];
        return;
    }

    UIViewController *nextVC = [[NSClassFromString(itemModel.className) alloc] init];
    self.viewController.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    headerView.cv_backColor(UIColor.clearColor);
    [headerView addSubview:self.logoutButton];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _rowHeight + 20.f;
}

- (UIButton *)logoutButton {
    if (! _logoutButton) {
        CGFloat margin = 14.f;
        UIButton *button = UIButton.cb_button().cb_title(@"退出登录").cb_fontSize(15.f).cb_titleColor(UIColor.whiteColor);
        _logoutButton = button;
        button.cv_frameOf(margin, 20.f, kScreenWidth - margin * 2.f, _rowHeight).cv_backColor(UIColor.cc_colorByHexString(@"#F76F6F"));
        button.layer.cornerRadius = 5.f;
    }
    return _logoutButton;
}

@end
