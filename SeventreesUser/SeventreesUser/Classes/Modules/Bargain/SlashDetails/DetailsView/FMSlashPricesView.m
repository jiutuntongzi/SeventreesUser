//
//  FMSlashPricesView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashPricesView.h"

@interface FMSlashPricesView ()

@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

@implementation FMSlashPricesView

- (void)fm_bindViewModel {
    [[_buyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

@end
