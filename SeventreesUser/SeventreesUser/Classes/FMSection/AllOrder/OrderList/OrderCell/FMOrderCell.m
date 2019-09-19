//
//  FMOrderCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderCell.h"
#import "FMGoodsInDetailsCell.h"

@interface FMOrderCell () <UITableViewDataSource, UITableViewDelegate>

/// header

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

/// footer

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation FMOrderCell

- (void)fm_setupSubviews {
    self.ctc_selectedColor(nil);
    
    void (^setStyleBlock)(UIView *, UIColor *) = ^(UIView *view, UIColor *color) {
        view.layer.cornerRadius = 13.f;
        view.layer.borderColor = color.CGColor;
        view.layer.borderWidth = 1.f;
    };
    setStyleBlock(_leftButton, UIColor.cc_colorByHexString(@"#333333"));
    setStyleBlock(_rightButton, UIColor.cc_colorByHexString(@"#F76F6F"));
}

- (void)fm_bindViewModel {
    [[_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // code..
    }];
    [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // code..
    }];
    
    
}

- (FMOrderCellViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMOrderCellViewModel alloc] init];
    }
    return _viewModel;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMGoodsInDetailsCell *cell = FMGoodsInDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.ctc_selectionStyle(UITableViewCellSelectionStyleNone);
//    cell.goodsModel = self.viewModel.;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath == %@", indexPath);
}

@end
