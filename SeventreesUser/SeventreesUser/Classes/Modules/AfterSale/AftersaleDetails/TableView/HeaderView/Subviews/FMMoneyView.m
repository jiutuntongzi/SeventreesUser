//
//  FMMoneyView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMoneyView.h"

@interface FMMoneyView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *moneyLabel;

@end

@implementation FMMoneyView

- (void)setTitle:(NSString *)title {
    _title = title;
    
}

- (void)setMoney:(NSNumber *)money {
    _money = money;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

@end
