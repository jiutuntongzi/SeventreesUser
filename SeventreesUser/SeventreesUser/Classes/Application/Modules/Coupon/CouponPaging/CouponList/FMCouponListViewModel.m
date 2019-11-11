//
//  FMCouponListViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCouponListViewModel.h"

@implementation FMCouponListViewModel

- (void)fm_initialize {
    _status = 1;    // 默认请求参数
    
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
        }
        /*
        NSArray *couponEntitys = [[FMCouponModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        for (FMCouponModel *couponEntity in couponEntitys) {
            couponEntity.status = self->_status;
        }
        self.couponEntitys = couponEntitys;
        */
        
        /// test
        NSArray *dictAry = @[
                             @{
                                 @"status": @(self->_status),
                                 @"name": @"折扣券",   // -- 优惠卷名
                                 @"id": @(1),       // -- 优惠卷ID
                                 @"type": @"2",     //  -- 优惠卷类型（1 = 现金卷 2 = 折扣卷）
                                 @"discount": @(9.80),  //  --优惠卷折扣
                                 @"amount": @(8.00),     //  --优惠卷金额
                                 @"startTime": @"2019-09-20 11:19:43", // --有效时间
                                 @"endTime": @"2019-09-29 11:19:43",  // --失效时间
                                 @"remake": @"折扣券",        // --备注
                                 @"applicable": @(98.00)          // --适用金额满XX可用
                                 },
                             @{
                                 @"status": @(self->_status),
                                 @"id": @(2),       // -- 优惠卷ID
                                 @"name": @"现金卷",   // -- 优惠卷名
                                 @"type": @"1",     //  -- 优惠卷类型（1 = 现金卷 2 = 折扣卷）
                                 @"discount": @(9.80),  //  --优惠卷折扣
                                 @"amount": @(8.00),     //  --优惠卷金额
                                 @"startTime": @"2019-09-20 11:19:43", // --有效时间
                                 @"endTime": @"2019-09-29 11:19:43",  // --失效时间
                                 @"remake": @"折扣券",        // --备注
                                 @"applicable": @(98.00)          // --适用金额满XX可用
                                 },
                             @{
                                 @"status": @(self->_status),
                                 @"id": @(3),       // -- 优惠卷ID
                                 @"name": @"免费券",   // -- 优惠卷名
                                 @"type": @"3",     //  -- 优惠卷类型（1 = 现金卷 2 = 折扣卷）
                                 @"discount": @(9.80),  //  --优惠卷折扣
                                 @"amount": @(8.00),     //  --优惠卷金额
                                 @"startTime": @"2019-09-20 11:19:43", // --有效时间
                                 @"endTime": @"2019-09-29 11:19:43",  // --失效时间
                                 @"remake": @"折扣券",        // --备注
                                 @"applicable": @(98.00)          // --适用金额满XX可用
                                 },
                             @{
                                 @"status": @(self->_status),
                                 @"id": @(4),       // -- 优惠卷ID
                                 @"name": @"特价卷",   // -- 优惠卷名
                                 @"type": @"4",     //  -- 优惠卷类型（1 = 现金卷 2 = 折扣卷）
                                 @"discount": @(9.80),  //  --优惠卷折扣
                                 @"amount": @(8.00),     //  --优惠卷金额
                                 @"startTime": @"2019-09-20 11:19:43", // --有效时间
                                 @"endTime": @"2019-09-29 11:19:43",  // --失效时间
                                 @"remake": @"折扣券",        // --备注
                                 @"applicable": @(98.00)          // --适用金额满XX可用
                                 }
                             ];
        NSArray *couponEntitys = [[FMCouponModel mj_objectArrayWithKeyValuesArray:dictAry] copy];
        self.couponEntitys = couponEntitys;
        
        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *status) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                if (status) self->_status = status.integerValue;
                [networkMgr GET:kCouponListQueryURIPath params:@{@"status": @(self->_status)} success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                    [self.showHintSubject sendNext:error.localizedDescription];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}

@end
