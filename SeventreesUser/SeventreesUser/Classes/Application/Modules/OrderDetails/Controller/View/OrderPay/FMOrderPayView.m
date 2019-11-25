//
//  FMOrderPayView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderPayView.h"

#import "FMPayController.h"
#import "FMSubmitEvaluateController.h"

@interface FMOrderPayView ()

@property (nonatomic, weak) IBOutlet UIButton *leftButton;

@property (nonatomic, weak) IBOutlet UIButton *rightButton;

@end

@implementation FMOrderPayView

- (void)fm_setupSubviews {
    void (^setStyleBlock)(UIView *, UIColor *) = ^(UIView *view, UIColor *color) {
        view.layer.cornerRadius = 15.f;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = color.CGColor;
        [view clipsToBounds];
    };
    setStyleBlock(_leftButton, UIColor.cc_colorByHexString(@"#DCDCDC"));
    setStyleBlock(_rightButton, UIColor.cc_colorByHexString(@"#F76F6F"));
}

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self.viewModel, orderStatus) subscribeNext:^(NSNumber *orderStatusNumber) {
        @strongify(self)

        // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
        NSString *orderStatus = nil, *leftTitle = nil, *rightTitle = nil;
        switch (orderStatusNumber.integerValue) {
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
        
        if (leftTitle == nil && rightTitle == nil) {
            self.hidden = YES;
            return;
        }
        self.hidden = NO;
        
        self->_leftButton.hidden = leftTitle == nil;
        if (leftTitle != nil) self->_leftButton.cb_title(leftTitle);
        
        self->_rightButton.hidden = rightTitle == nil;
        if (rightTitle != nil) self->_rightButton.cb_title(rightTitle);
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    void (^orderOperateBlock)(NSInteger, BOOL) = ^(NSInteger orderStatus, BOOL isLeft) {
        @strongify(self)
        switch (orderStatus) {
            case 1: {
                //              orderStatus = @"待付款";  leftTitle = @"取消订单";  rightTitle = @"去支付";
                if (isLeft) {
                    DLog(@"点了取消订单");
                    [self.viewModel.requestCancelCommand execute:nil];
                } else {
                    DLog(@"点了去支付");
                    FMPayController *paymentNextVC = [[FMPayController alloc] init];
                    paymentNextVC.orderId = self.viewModel.orderId;
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
                    [self.viewModel.requestReceivingCommand execute:nil];
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
        orderOperateBlock(self.viewModel.orderStatus.integerValue, YES);
    }];
    
    [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self)
        orderOperateBlock(self.viewModel.orderStatus.integerValue, NO);
    }];
    
    [FMOrderPayView showRequestHUDStatus:nil command:self.viewModel.requestReceivingCommand];
    
    [FMOrderPayView showRequestHUDStatus:nil command:self.viewModel.requestCancelCommand];
    
    [FMOrderPayView showStatusInfoBySubject:self.viewModel.showHintSubject];
}

- (FMOrderPayViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMOrderPayViewModel alloc] init];
    }
    return _viewModel;
}
    
@end
