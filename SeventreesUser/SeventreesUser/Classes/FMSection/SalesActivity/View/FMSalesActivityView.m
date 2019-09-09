//
//  FMSalesActivityView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSalesActivityView.h"

#import "FMSpellGoodsCell.h"

@interface FMSalesActivityView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bigImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigImgViewHeightConst;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    FMSpellGoodsCell *cell = FMSpellGoodsCell.ctc_cellReuseNibLoadForTableView(tableView);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DLog(@"点了第%ld行", indexPath.row);
}

#pragma mark - Lazyload

- (FMSalesActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSalesActivityViewModel alloc] init];
    }
    return _viewModel;
}

@end
