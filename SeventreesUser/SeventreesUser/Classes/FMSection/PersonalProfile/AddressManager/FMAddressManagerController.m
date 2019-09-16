//
//  FMAddressManagerController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAddressManagerController.h"
#import "FMAddressInfoCell.h"

#import "FMNewAddressController.h"

@interface FMAddressManagerController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UIButton *addNewButton;

@end

@implementation FMAddressManagerController

- (void)showAddressVC:(FMNewAddressControllerPageStyle)stype {
    FMNewAddressController *nextVC = [[FMNewAddressController alloc] init];
    nextVC.stype = stype;
    self.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)fm_addSubviews {
    @weakify(self)
    [[_addNewButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        [self showAddressVC:FMNewAddressControllerPageStyleNew];
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"地址管理";
}

- (void)fm_refreshData {
    
}

#pragma mark ——— <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMAddressInfoCell *cell = FMAddressInfoCell.ctc_cellReuseNibLoadForTableView(tableView);
//    cell.model =
    
    cell.editActionBlock = ^(FMAddressInfoModel *addressModel) {
        [self showAddressVC:FMNewAddressControllerPageStyleEdit];
    };
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark ——— <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
