//
//  FMGoodsPictureListView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsPictureListView.h"

#import "FMPictureTableView.h"
#import "FMPictureCell.h"

@interface FMGoodsPictureListView () <UITableViewDataSource>

@property (nonatomic, strong) FMPictureTableView *tableView;

@end

@implementation FMGoodsPictureListView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMGoodsPictureListViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMGoodsPictureListViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    _tableView = [[FMPictureTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 255.f;
    [self addSubview:_tableView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)reloadTableView {
//    [_tableView updateConstraints:^(MASConstraintMaker *make) {
//        make.height
//    }];
    [_tableView reloadData];
}

- (void)fm_bindViewModel {
//    @weakify(self);
//
//    [[_arrowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//
//        [self.viewModel.actionSubject sendNext:self.viewModel.model];
//    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMPictureCell *cell = FMPictureCell.ctc_cellReuseForTableView(tableView);
    cell.imgURLString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568102004&di=53d47b12ed5c5a896637f8346658fda6&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201802%2F25%2F20180225080939_E8rAt.jpeg";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

#pragma mark ——— <UITableViewDelegate>

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    return glo_rowHeight();
//}
//
//inline static CGFloat glo_rowHeight() {
//    CGFloat rlMargin = 12.f, lrMargin = 15.f, topMargin = 55.f;
//    CGFloat itemWidth = (kScreenWidth - lrMargin * 2.f - rlMargin) * 0.5;
//    CGFloat itemHeight = itemWidth * 1.42f;
//    return itemHeight * 2.f + rlMargin + topMargin;
//}

#pragma mark - Lazyload

- (FMGoodsPictureListViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMGoodsPictureListViewModel alloc] init];
    }
    return _viewModel;
}


@end
