//
//  FMOrderExplainView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderExplainView.h"

@interface FMOrderExplainView ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *fuzhiButton;

@end

@implementation FMOrderExplainView

- (void)fm_setupSubviews {
    void (^setStyleBlock)(UIView *) = ^(UIView *view) {
        view.layer.cornerRadius = 3.f;
        view.layer.borderWidth = 1.f;
        view.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    };
    setStyleBlock(_fuzhiButton);
}

- (void)fm_bindObserver {
    @weakify(self)
    
    [RACObserve(self, orderInfoText) subscribeNext:^(NSString *orderInfoText) {
        @strongify(self)
        
        self->_textView.text = orderInfoText;
        if (orderInfoText) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 5; // 行间距
            NSDictionary *attributes = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:12.f],
                                         NSParagraphStyleAttributeName:paragraphStyle,
                                         NSForegroundColorAttributeName: UIColor.cc_colorByHexString(@"#999999")
                                         };
            self->_textView.attributedText = [[NSAttributedString alloc] initWithString:orderInfoText attributes:attributes];
        }
    }];
    
    [RACObserve(self, orderExplainEntity) subscribeNext:^(FMOrderExplainModel *explainEntity) {
        @strongify(self)
        
        NSString *explainInfoText = [NSString stringWithFormat:@"订单编号：%@ \n下单时间：%@ \n下单门店：%@ \n物流公司：%@ \n物流单号：%@",\
                                     explainEntity.orderCode, explainEntity.createOrderTime, explainEntity.storeName,\
                                     explainEntity.logisticsName, explainEntity.logisticsCode];
        self.orderInfoText = explainInfoText;
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    [[_fuzhiButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [UIPasteboard generalPasteboard].string = self->_orderInfoText;
        [SVProgressHUD showSuccessWithStatus:@"已复制到粘贴板"];
        [SVProgressHUD  dismissWithDelay:1.0f];
    }];
}

@end
