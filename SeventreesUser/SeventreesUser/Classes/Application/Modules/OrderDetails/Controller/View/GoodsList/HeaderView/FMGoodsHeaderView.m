//
//  FMGoodsHeaderView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsHeaderView.h"

const CGFloat FMGoodsHeaderViewHeight = kFixedHeight;

@interface FMGoodsHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *goodsTotalLabel;

@end

@implementation FMGoodsHeaderView

- (void)fm_bindObserver {
    @weakify(self)
    [RACObserve(self, goodsTotal) subscribeNext:^(NSNumber *goodsTotal) {
        @strongify(self)
        self->_goodsTotalLabel.text = [NSString stringWithFormat:@"共%ld件", self->_goodsTotal];
    }];
}

@end
