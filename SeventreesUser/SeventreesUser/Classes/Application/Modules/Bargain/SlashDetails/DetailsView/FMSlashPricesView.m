//
//  FMSlashPricesView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashPricesView.h"

@interface FMSlashPricesView ()

@property (weak, nonatomic) IBOutlet UILabel *curPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sparePriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@end

@implementation FMSlashPricesView

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, priceEntity) subscribeNext:^(FMSlashPriceModel *priceEntity) {
        @strongify(self)
        self->_curPriceLabel.text = [NSString stringWithFormat:@"¥%.2f", priceEntity.curPrice];
        self->_sparePriceLabel.text = [NSString stringWithFormat:@"为您节省了¥%.2f", priceEntity.favourablePrice];
        self->_buyButton.cb_title([NSString stringWithFormat:@"以¥%.2f购买", priceEntity.floorPrice]);
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [[_buyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        DLog(@"点了%@", self->_buyButton.titleLabel.text);
    }];
}

@end
