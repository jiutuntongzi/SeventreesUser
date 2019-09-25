//
//  FMPersonalProfileView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPersonalProfileView.h"

#import "FMPersonalInfoCell.h"
#import "FMPersonalInfoModel.h"

#import "FMImgHeaderView.h"
#import "FMSelectFooterView.h"


#import "DialogBoxView.h"
#import "BRPickerView.h"
#import "BRStringPickerView.h"

@interface FMPersonalProfileView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *selectItems;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) CGFloat rowHeight;

@end

@implementation FMPersonalProfileView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

static const NSUInteger _rowCount = 4;
- (NSDictionary *)itemInfoForIndex:(NSUInteger)index {
    if (! _selectItems) {
        NSString * const title = @"title";
        NSString * const subTitle = @"subTitle";
        
        _selectItems = @{
                     @(0) : @{
                             title           : @"昵称",
                             subTitle        : @"请设置昵称",
                             },
                     @(1) : @{
                             title           : @"姓名",
                             subTitle        : @"请填写姓名",
                             },
                     @(2) : @{
                             title           : @"生日",
                             subTitle        : @"请设置生日",
                             },
                     @(3) : @{
                             title           : @"性别",
                             subTitle        : @"请选择性别",
                             },
                     };
        
    }
    return _selectItems[@(index)];
}

- (void)fm_setupSubviews {
    _rowHeight = kFixedHeight;
    self.cv_backColor(UIColor.whiteColor);
    
    [self setupTableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setupTableView {
    CGFloat width = self.bounds.size.width, height = self.bounds.size.height;
    UITableView *tableView = UITableView.ct_tableViewWithFrameStyle(0.f, 0.f, width, height, UITableViewStylePlain)\
    .ct_dataSource(self).ct_delegate(self)\
    .ct_rowHeight(_rowHeight).ct_separatorStyle(UITableViewCellSeparatorStyleSingleLine).ct_separatorColor(UIColor.cc_colorByHexString(@"#E5E5E5"))\
    .ct_separatorInset(UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f));
    tableView.cv_backColorByHexString(@"#F7F7F7");
    tableView.bounces = YES;
    self->_tableView = tableView;
    
    [self addSubview:tableView];
}

- (void)fm_bindViewModel {
//    @weakify(self);
//
//    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//
//        [self.viewModel.actionSubject sendNext:nil];
//    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self); // make.left.right.top.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMPersonalProfileViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMPersonalProfileViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMPersonalInfoCell *cell = FMPersonalInfoCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.itemModel = [FMPersonalInfoModel modelWithDictionary:[self itemInfoForIndex:indexPath.row]];
    if (indexPath.row % 2 == 0) {
        cell.subTitle = @"测试颜色";
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowCount;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DLog(@"点了第%ld行", (long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *placeholder = @"最多可输入6位中文字符", *affirmTitle = @"确认保存";
    if (indexPath.row == 0) {
        [DialogBoxView showByTitle:@"请设置昵称" message:placeholder affirmButtonTitle:affirmTitle forStyle:DialogBoxViewStyleInput affirmHandler:^(NSString * _Nullable inputText) {
            DLog(@"inputText == %@", inputText);
            if (inputText.length > 6) {
                [SVProgressHUD showInfoWithStatus:placeholder];
                [SVProgressHUD dismissWithDelay:1.f];
                return;
            }
            
        }];
    } else if (indexPath.row == 1) {
        [DialogBoxView showByTitle:@"请填写姓名" message:placeholder affirmButtonTitle:affirmTitle forStyle:DialogBoxViewStyleInput affirmHandler:^(NSString * _Nullable inputText) {
            DLog(@"inputText == %@", inputText);
            if (inputText.length > 6) {
                [SVProgressHUD showInfoWithStatus:placeholder];
                [SVProgressHUD dismissWithDelay:1.f];
                return;
            }
            
        }];
    } else if (indexPath.row == 2) {
        NSDate *minDate = [NSDate br_setYear:1900 month:0 day:0];
        NSDate *maxDate = [NSDate distantFuture];
        [BRDatePickerView showDatePickerWithTitle:@"" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectTime) {
            DLog(@"selectTime == %@", selectTime);
        } cancelBlock:^{
            
        }];
        
    } else if (indexPath.row == 3) {
//        self.viewController.cvc_showSheetControllerByTitleNamesCompleted(nil, @[@"男", @"女"], ^(NSUInteger index) {
//        });
        [BRStringPickerView showStringPickerWithTitle:@"" dataSource:@[@"男", @"女"] defaultSelValue:@"" isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectText, NSInteger selectIdx) {
            
        } cancelBlock:^{
            DLog(@"取消");
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FMImgHeaderView *imgHeaderView = (FMImgHeaderView *)FMImgHeaderView.cv_viewFromNibLoad();
    imgHeaderView.frame = CGRectZero;
    
    imgHeaderView.cv_addTouchEventCallback(^(UIView *view) {
        DLog(@"点了头像 headerView");
    });
    return imgHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _rowHeight + 16.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, _rowHeight + 15.f)];
    footerView.cv_backColor(UIColor.clearColor);
    
    FMSelectFooterView *selectFooterView = (FMSelectFooterView *)FMSelectFooterView.cv_viewFromNibLoad();
    selectFooterView.frame = CGRectMake(0.f, 15.f, footerView.width, _rowHeight);
    
    __weak typeof(self) weakSelf = self;
    selectFooterView.cv_addTouchEventCallback(^(UIView *view) {
        DLog(@"点了地址管理 footerView");
        [weakSelf.viewModel.nextActionSubject sendNext:nil];
    });
    
    [footerView addSubview:selectFooterView];
    
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _rowHeight + 15.f;
}

@end
