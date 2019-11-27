//
//  FMRefundFooterView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMRefundExplainModel.h"

extern CGFloat FMRefundFooterView_height;

@interface FMRefundFooterView : UIView

/** 添加显示物流快递：1：六行  /  0：四行 */
- (instancetype)initWithStyle:(UInt8)style;

@property (nonatomic, strong) FMRefundExplainModel *explainEntity;

@end
