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

const CGFloat FMGoodsPictureListViewRowHeight = 268.f;

@interface FMGoodsPictureListView () <UITableViewDataSource>

@property (nonatomic, strong) FMPictureTableView *tableView;

@property (nonatomic, strong) UIView *titleView;


@end

@implementation FMGoodsPictureListView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

//- (void)setViewModel:(FMGoodsPictureListViewModel *)viewModel {
//    _viewModel = viewModel;
//
//
//}
//
//- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
//    _viewModel = (FMGoodsPictureListViewModel *)_viewModel;
//
//    return [super initWithViewModel:viewModel];
//}

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    UIView *titleView = UIView.cv_view();
    _titleView = titleView;
    self.cv_addSubview(titleView);
    
    
    UILabel *titleLabel = UILabel.cl_label();
    titleLabel.cl_text(@"商品详情").cl_textAlignment(NSTextAlignmentCenter).cl_fontSize(14.f).cl_textColor(UIColor.cc_colorByHexString(@"#333333"));
    titleView.cv_addSubview(titleLabel);
    
    _tableView = [[FMPictureTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.rowHeight = FMGoodsPictureListViewRowHeight;
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
    @weakify(self);
    
    [RACObserve(self.viewModel, imageURLStrings) subscribeNext:^(NSArray<NSString *> *imageURLStrings) {
        @strongify(self);
        [self reloadTableView];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    CGFloat height = kFixedHeight;
    [_titleView makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
        make.left.top.right.equalTo(self);
    }];
    
    UILabel *titleLabel = _titleView.subviews.firstObject;
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_titleView);
    }];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(height);
        make.left.right.bottom.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMPictureCell *cell = FMPictureCell.ctc_cellReuseForTableView(tableView);
    cell.imgURLString = self.viewModel.imageURLStrings[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.imageURLStrings.count;
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
