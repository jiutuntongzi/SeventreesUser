//
//  FMRefundExplainView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundExplainView.h"

@interface FMRefundExplainView ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, copy) NSString *infoText;

@end

@implementation FMRefundExplainView

- (void)setExplainEntity:(FMRefundExplainModel *)explainEntity {
    _explainEntity = explainEntity;
    
    NSString *applyMoney = @"--";
    if (explainEntity.amount) [NSString stringWithFormat:@"￥%.2f", explainEntity.amount.floatValue];
    
    NSString *explainText = [NSString stringWithFormat:@"退款原因：%@ \n\n申请金额：%@ \n\n申请时间：%@ \n\n退款编号：%@ \n\n物流公司：%@ \n\n物流单号：%@",\
                             explainEntity.reason ?: @"--", applyMoney, explainEntity.createdDateTime ?: @"--", explainEntity.serialNumber ?: @"--",
                             explainEntity.logisticsCompany ?: @"--", explainEntity.logisticsCompany ?: @"--"];
    self.infoText = explainText;
}

- (void)setInfoText:(NSString *)infoText {
    _infoText = infoText;
    _textView.text = infoText;
}

@end
