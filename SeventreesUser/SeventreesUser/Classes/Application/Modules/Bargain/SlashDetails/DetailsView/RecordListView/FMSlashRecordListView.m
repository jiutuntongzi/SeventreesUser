//
//  FMSlashRecordListView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashRecordListView.h"
#import "FMSlashRecordCell.h"

@interface FMSlashRecordListView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMSlashRecordListView

- (void)fm_setupSubviews {
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = FMSlashRecordCellHeight;
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, joinUserEntitys) subscribeNext:^(NSArray<FMBargainUserModel *> *joinUserEntitys) {
        @strongify(self)    if (!self) return;
        self->_totalLabel.text = [NSString stringWithFormat:@"已有%lu位好友助力", joinUserEntitys.count];
        [self->_tableView reloadData];
    }];
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMSlashRecordCell *cell = FMSlashRecordCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.joinUserEntity = self.joinUserEntitys[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.joinUserEntitys.count;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"点了第%ld行", indexPath.row);
}

@end
