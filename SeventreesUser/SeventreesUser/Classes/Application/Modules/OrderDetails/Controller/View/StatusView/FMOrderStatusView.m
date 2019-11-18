//
//  FMOrderStatusView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderStatusView.h"

@interface FMOrderStatusView ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *remainTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;

@end

@implementation FMOrderStatusView

- (void)fm_setupSubviews {
    self.cv_backColorByHexString(@"#F76F6F");
}

- (void)fm_bindObserver {
    @weakify(self)
    
    [RACObserve(self, orderStatus) subscribeNext:^(NSNumber *orderStatus) {
        @strongify(self)
        // --订单状态（1 未付款 2 拣货中 3已关闭 4 已发货 5 未评价 6 退货中 7 已退货 8 拒接退货 9 订单取消 10 部分已发货 11已完成）
        NSString *statusText = nil, *statusIconName = nil;
        switch (orderStatus.integerValue) {
            case 1: {
                statusText = @"待付款";
                statusIconName = @"icon_orderStatus_waitPay";
//                leftTitle = @"取消订单";
//                rightTitle = @"去支付";
                break;
            }
            case 2: {
                statusText = @"待发货";
                statusIconName = @"icon_orderStatus_waitSend";
//                leftTitle = @"申请退款";
                break;
            }
            case 3: {
                statusText = @"已关闭";
                statusIconName = @"icon_orderStatus_yetClose";
                break;
            }
            case 4: {
                statusText = @"待收货";
                statusIconName = @"icon_orderStatus_waitReceive";
//                leftTitle = @"申请退货";
//                rightTitle = @"确认收货";
                break;
            }
            case 5: {
                statusText = @"待评论";
                statusIconName = @"icon_orderStatus_waitEvaluate";
//                leftTitle = @"申请退货";
//                rightTitle = @"去评论";
                break;
            }
            case 6: {
                statusText = @"退货中";
                statusIconName = @"icon_orderStatus_refunding";
                break;
            }
            case 7: {
                statusText = @"已退货";
                statusIconName = @"icon_orderStatus_yetRefund";
                break;
            }
            case 8: {
                statusText = @"拒绝退货";
                statusIconName = @"icon_orderStatus_refusedRefund";
                break;
            }
            case 9: {
                statusText = @"订单取消";
                statusIconName = @"icon_orderStatus_yetCancel";
                break;
            }
            case 10: {
                statusText = @"部分已发货";
                statusIconName = @"icon_orderStatus_partShipped";
                
                break;
            }
            case 11: {
                statusText = @"已完成";
                statusIconName = @"icon_orderStatus_yetFinish";
                break;
            }
            default:
                break;
        }
        
        self->_statusLabel.text = statusText ?: @"--";
        self->_statusImgView.image = UIImage.ci_imageNamed(statusIconName);
    }];
    
    [RACObserve(self, remainTime) subscribeNext:^(NSNumber *remainTime) {
        @strongify(self)
//        NSString *formatTime = [NSString convertTimeFromTimestamp:remainTime.unsignedIntegerValue dateformatter:@"HH:mm:ss"]; // @"yyyy-MM-dd HH:mm:ss"
        NSString *countdownTime = formatTimeMsec(remainTime.integerValue);
        self->_remainTimeLabel.text = [NSString stringWithFormat:@"剩%@自动关闭", countdownTime];
    }];
}

/**
 * 毫秒转化为天小时分钟秒
 *
 * @param ms (毫秒值)
 * @return countdown time （倒计时时间）
 */
NSString * formatTimeMsec(long ms) {
    int ss = 1000;
    int mi = ss * 60;
    int hh = mi * 60;
    int dd = hh * 24;
    
    long day = ms / dd;
    long hour = (ms - day * dd) / hh;
    long minute = (ms - day * dd - hour * hh)/ mi;
    long second = (ms - day * dd - hour * hh - minute * mi) * 1.0 / ss;
    // long milliSecond = ms - day * dd - hour * hh - minute * mi - second * ss;
    if (day > 0) {
        return [NSString stringWithFormat:@"%ld%@%ld%@%ld%@", day, @"天", hour, @"小时", minute, @"分"];
    } else if (hour > 0) {
        return [NSString stringWithFormat:@"%ld%@%ld%@", hour, @"小时", minute, @"分"];
    } else if (minute > 0) {
        return [NSString stringWithFormat:@"%ld%@",minute, @"分"];
    } else if (second > 0) {
        return [NSString stringWithFormat:@"%ld%@", second, @"秒"];
    } else {
        return [NSString stringWithFormat:@"%d%@%d%@", 0, @"小时", 0, @"分"];
    }
}

@end
