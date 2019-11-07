//
//  FMSalesActivityView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSalesActivityView.h"

#import "FMActivityGoodsCell.h"

@interface FMSalesActivityView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *headerImgView;

@end

@implementation FMSalesActivityView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMSalesActivityViewModel *)viewModel {
    _viewModel = viewModel;
    

}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMSalesActivityViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [self.viewModel.refreshUISubject subscribeNext:^(id x) {
        @strongify(self);
        
        DLog(@"刷新页面：x == %@", x);
        
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMActivityGoodsCell *cell = FMActivityGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DLog(@"点了第%ld行", indexPath.row);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test123"]];
    _headerImgView = imgView;
    imgView.frame = CGRectMake(0.f, 0.f, self.width, 149.f);
    [headerView addSubview:imgView];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 149.f;
}

#pragma mark - Lazyload

- (FMSalesActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSalesActivityViewModel alloc] init];
    }
    return _viewModel;
}

@end
