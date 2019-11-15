//
//  FMOrderCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderCell.h"
#import "FMGoodsInDetailsCell.h"
#include "FMOrderPagingType.h"

#import "FMPayController.h"
#import "FMSubmitEvaluateController.h"

@interface FMOrderCell () <UITableViewDataSource, UITableViewDelegate>

/// header

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;

/// footer

@property (nonatomic, weak) IBOutlet UILabel *totalLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@property (nonatomic, weak) IBOutlet UIButton *leftButton;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation FMOrderCell

- (void)fm_setupSubviews {
    self.ctc_selectionStyle(0);
    
    void (^setStyleBlock)(UIView *, UIColor *) = ^(UIView *view, UIColor *color) {
        view.layer.cornerRadius = 12.f;
        view.layer.borderColor = color.CGColor;
        view.layer.borderWidth = 1.f;
    };
    setStyleBlock(_leftButton, UIColor.cc_colorByHexString(@"#E5E5E5"));
    setStyleBlock(_rightButton, UIColor.cc_colorByHexString(@"#F76F6F"));
}

- (void)setViewModel:(FMOrderCellViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self fm_bindViewModel];
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, viewModel.orderEntity) subscribeNext:^(FMOrderModel *orderEntity) {
        @strongify(self)
        
        [self->_tableView reloadData];
        
        self->_priceLabel.text = [NSString stringWithFormat:@"￥%.2f", orderEntity.orderPrice.doubleValue];
        self->_totalLabel.text = [NSString stringWithFormat:@"共%lu件商品", orderEntity.goodsDetailModels.count];
        
        self->_titleLabel.text = orderEntity.createTime ?: @"--";
        
        
        // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
        NSString *orderStatus, *leftTitle, *rightTitle;
        if (global_orderType == FMOrderPagingTypeWaitPay) {
            if (orderEntity.orderStatus.integerValue == 1) {
                orderStatus = @"待付款";
                leftTitle = @"取消订单";    rightTitle = @"去支付";
            }
        } else if (global_orderType == FMOrderPagingTypeWaitSend) {
            if (orderEntity.orderStatus.integerValue == 2) {
                orderStatus = @"待发货";
                leftTitle = @"申请退款";
            }
        } else if (global_orderType == FMOrderPagingTypeWaitReceive) {
            if (orderEntity.orderStatus.integerValue == 4) {
                orderStatus = @"待收货";
                
                leftTitle = @"申请退货";
                rightTitle = @"确认收货";
            }
        } else if (global_orderType == FMOrderPagingTypeWaitEvaluate) {
            if (orderEntity.orderStatus.integerValue == 5) {
                orderStatus = @"待评论";
                
                leftTitle = @"申请退货";
                rightTitle = @"去评论";
            }
        } else {   // FMOrderPagingTypeAll
            switch (orderEntity.orderStatus.integerValue) {
                case 1: {
                    orderStatus = @"待付款";
                    
                    leftTitle = @"取消订单";
                    rightTitle = @"去支付";
                    break;
                }
                case 2: {
                    orderStatus = @"待发货";
                    
                    leftTitle = @"申请退款";
                    break;
                }
                case 3: {
                    orderStatus = @"已关闭";
                    break;
                }
                case 4: {
                    orderStatus = @"待收货";
                    
                    leftTitle = @"申请退货";
                    rightTitle = @"确认收货";
                    break;
                }
                case 5: {
                    orderStatus = @"待评论";
                    
                    leftTitle = @"申请退货";
                    rightTitle = @"去评论";
                    break;
                }
                case 6: {
                    orderStatus = @"退货中";
                    break;
                }
                case 7: {
                    orderStatus = @"已退货";
                    break;
                }
                case 8: {
                    orderStatus = @"拒绝退货";
                    break;
                }
                case 9: {
                    orderStatus = @"订单取消";
                    break;
                }
                case 10: {
                    orderStatus = @"部分已发货";
                    break;
                }
                case 11: {
                    orderStatus = @"已完成";
                    break;
                }
                default:
                    break;
            }
        }
        
        self->_statusLabel.text = orderStatus ?: @"--";
        
        self->_leftButton.hidden = leftTitle == nil;
        if (leftTitle != nil) self->_leftButton.cb_title(leftTitle);
        
        self->_rightButton.hidden = rightTitle == nil;
        if (rightTitle != nil) self->_rightButton.cb_title(rightTitle);
    }];
}

- (void)fm_bindViewModel {
    if (_viewModel == nil) return;
    
    @weakify(self)
    
    void (^orderOperateBlock)(NSInteger, BOOL) = ^(NSInteger orderStatus, BOOL isLeft) {
        @strongify(self)
        switch (orderStatus) {
            case 1: {
//              orderStatus = @"待付款";  leftTitle = @"取消订单";  rightTitle = @"去支付";
                if (isLeft) {
                    DLog(@"点了取消订单");
                    [self->_viewModel.requestCancelCommand execute:nil];
                } else {
                    DLog(@"点了去支付");
                    FMPayController *paymentNextVC = [[FMPayController alloc] init];
                    paymentNextVC.orderId = self->_viewModel.orderEntity.orderId;
                    [self.viewController.navigationController pushViewController:paymentNextVC animated:YES];
                }
                break;
            }
            case 2: {
//              orderStatus = @"待发货";  leftTitle = @"申请退款";
                if (isLeft) {
                    DLog(@"点了申请退款");
                } else {
//                    DLog(@"点了右");
                }
                break;
            }
            case 4: {
//              orderStatus = @"待收货";  leftTitle = @"申请退货";  rightTitle = @"确认收货";
                if (isLeft) {
                    DLog(@"点了申请退货");
                } else {
                    DLog(@"点了确认收货");
                    [self->_viewModel.requestReceivingCommand execute:nil];
                }
                break;
            }
            case 5: {
//              orderStatus = @"待评论";  leftTitle = @"申请退货";  rightTitle = @"去评论";
                if (isLeft) {
                    DLog(@"点了申请退货");
                } else {
                    DLog(@"点了去评论");
                    FMSubmitEvaluateController *evaluateNextVC = [[FMSubmitEvaluateController alloc] init];
                    [self.viewController.navigationController pushViewController:evaluateNextVC animated:YES];
                }
                break;
            }
        }
    };
    
    [[_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self)
        orderOperateBlock(self->_viewModel.orderEntity.orderStatus.integerValue, YES);
    }];
    
    [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self)
        orderOperateBlock(self->_viewModel.orderEntity.orderStatus.integerValue, NO);
    }];
    
    [[_viewModel.requestReceivingCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:nil];
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
    
    [[_viewModel.requestCancelCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:nil];
        } else {
            [SVProgressHUD dismissWithDelay:1.f];
        }
    }];
    
    [_viewModel.showHintSubject subscribeNext:^(NSString *status) {
        [SVProgressHUD showInfoWithStatus:status];
    }];
}

#pragma mark ——— <UITableViewDataSource, UITableViewDelegate>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMGoodsInDetailsCell *cell = FMGoodsInDetailsCell.ctc_cellReuseNibLoadForTableView(tableView);
    cell.goodsEntity = self->_viewModel.orderEntity.goodsDetailModels[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self->_viewModel.orderEntity.goodsDetailModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DLog(@"indexPath == %@", indexPath);
    [self.viewModel.nextVCSubject sendNext:self->_viewModel.orderEntity];
}

@end
