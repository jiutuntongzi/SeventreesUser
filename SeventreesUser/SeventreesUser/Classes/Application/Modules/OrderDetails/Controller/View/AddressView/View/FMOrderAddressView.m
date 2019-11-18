//
//  FMOrderAddressView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderAddressView.h"

@interface FMOrderAddressView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation FMOrderAddressView


- (void)fm_bindObserver {
    @weakify(self)
    
    /// 多信号合并订阅: 把元祖里的值分别都取出来，然后对这些值做一些操作，再合成一个结果值返回 (任意一个信号被触发都会被订阅)
    [[RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, mobilePhone)] reduce:^id _Nullable (NSString *userName, NSString *mobilePhone) {
        return [NSString stringWithFormat:@"%@    %@", userName, mobilePhone]; // 如：@"荼蘼之恋伤    13022345634"
    }] subscribeNext:^(NSString *userText) {
        @strongify(self)
        self->_titleLabel.text = userText;
    }];
    
    [RACObserve(self, addressDetails) subscribeNext:^(NSString *addressDetails) {
        @strongify(self)
        self->_subTitleLabel.text = addressDetails ?: @"--";
    }];
}

@end
