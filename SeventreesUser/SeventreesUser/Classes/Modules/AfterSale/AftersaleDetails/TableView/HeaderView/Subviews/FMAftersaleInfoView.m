//
//  FMAftersaleInfoView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAftersaleInfoView.h"
#import "MacroHeader.h"

#define     kViewDefalutHeight    128.f

CGFloat FMAftersaleInfoView_height = kViewDefalutHeight;

@interface FMAftersaleInfoView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@end

@implementation FMAftersaleInfoView

- (void)setStyle:(FMAftersaleInfoViewStyle)style {
    _style = style;
    
    void (^calculateHeightBlock)(FMAftersaleInfoViewStyle style) = ^ (FMAftersaleInfoViewStyle style) {
        if (IPHONE_6P || IPHONE_7P || IPHONE_8P || kISPhoneX || IPHONE_XR || IPHONE_XS_MAX || IPHONE_XS) {
            if (style == FMAftersaleInfoViewStyleRefunding) {
                FMAftersaleInfoView_height = 116.f;
            } else if (style == FMAftersaleInfoViewStyleWaitSend) {
                FMAftersaleInfoView_height = 110.f;
            } else if (style == FMAftersaleInfoViewStyleWaitReceive) {
                FMAftersaleInfoView_height = 90.f;
            }
        } else {
            if (style == FMAftersaleInfoViewStyleRefunding) {
                FMAftersaleInfoView_height = kViewDefalutHeight;
            } else if (style == FMAftersaleInfoViewStyleWaitSend) {
                FMAftersaleInfoView_height = kViewDefalutHeight;
            } else if (style == FMAftersaleInfoViewStyleWaitReceive) {
                FMAftersaleInfoView_height = 105.f;
            }
        }
    };
    
    switch (style) {
        case FMAftersaleInfoViewStyleRefunding: {
            _titleLabel.text = @"您已成功发起退款申请，请耐心等待商家处理";
            _detailsLabel.text = @"商家同意或者超时未处理，系统将退款给您";
            calculateHeightBlock(FMAftersaleInfoViewStyleRefunding);
            break;
        }
        case FMAftersaleInfoViewStyleWaitSend: {
            _titleLabel.text = @"您的退货申请已通过，填写发货信息";
            _detailsLabel.text = @"请将您需退货商品通过快递发回商家指定退货地址，并填写发货信息，商家验收通过后，系统会自动将退款金额退回您的原支付账户";
            calculateHeightBlock(FMAftersaleInfoViewStyleWaitSend);
            break;
        }
        case FMAftersaleInfoViewStyleWaitReceive: {
            _titleLabel.text = @"您的退货申请已通过，待商家验收";
            _detailsLabel.text = @"商家验收通过后，系统会自动将退款金额退回您的原支付账户";
            calculateHeightBlock(FMAftersaleInfoViewStyleWaitReceive);
            break;
        }
        case FMAftersaleInfoViewStyleRefundFailure: {
            _titleLabel.text = @"失败原因：商品已被顾客损坏，无法进行二次销售";
            _detailsLabel.text = nil;
            FMAftersaleInfoView_height = kFixedHeight;
            break;
        }
        default:
            break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /// 行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _detailsLabel.attributedText = [[NSAttributedString alloc] initWithString:_detailsLabel.text attributes:attributes];
}

@end
