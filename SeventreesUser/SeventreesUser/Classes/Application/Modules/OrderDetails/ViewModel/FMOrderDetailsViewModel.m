//
//  FMOrderDetailsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMOrderDetailsViewModel.h"


@implementation FMOrderDetailsViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        FMOrderDetailsModel *orderDetailsEntity = [FMOrderDetailsModel mj_objectWithKeyValues:resultModel.jsonDict[@"poOrderDetailsModel"]];
        
        /// 自定义的订单价格实体
        FMOrderPriceModel *orderPriceEntity = [[FMOrderPriceModel alloc] init];
        orderPriceEntity.goodsMoney = orderDetailsEntity.goodsMoney;
        orderPriceEntity.expressAmount = orderDetailsEntity.expressAmount;
        orderPriceEntity.knockMoney = orderDetailsEntity.knockMoney;
        orderPriceEntity.couponMoney = orderDetailsEntity.couponMoney;
        orderPriceEntity.integralMoney = orderDetailsEntity.integralMoney;
        orderPriceEntity.totalPrice = orderDetailsEntity.totalPrice;
        
        orderDetailsEntity.orderPriceEntity = orderPriceEntity;
        
        /// 自定义的订单说明实体
        FMOrderExplainModel *orderExplainEntity = [[FMOrderExplainModel alloc] init];
        orderExplainEntity.orderCode = orderDetailsEntity.orderCode;
        orderExplainEntity.createOrderTime = orderDetailsEntity.createOrderTime;
        orderExplainEntity.storeName = orderDetailsEntity.storeName;
        orderExplainEntity.logisticsName = orderDetailsEntity.logisticsName;
        orderExplainEntity.logisticsCode = orderDetailsEntity.logisticsCode;
        
        orderDetailsEntity.orderExplainEntity = orderExplainEntity;
        
        /// test goodsEntitys
        NSMutableArray *testGoodsEntitys = [[NSMutableArray alloc] init];
        for (NSUInteger idx = 0; idx != 2; idx++) {
            FMGoodsInDetailModel *goodsEntity = [[FMGoodsInDetailModel alloc] init];
            goodsEntity.goodsId = @(16);
            goodsEntity.goodsNum = @(idx);
            goodsEntity.goodsPrice = @(99.80);
            goodsEntity.goodsName = [@"humana奶粉_67年德国品质积累_值得妈妈信赖 humana值得妈妈信赖" stringByAppendingString:@(idx).stringValue];
            goodsEntity.goodsImage = @"http://shengmei1868.com/upload/20181026/7a37f8151c314523b5d289b7dad50452.png";
            [testGoodsEntitys addObject:goodsEntity];
        }
        orderDetailsEntity.goodsEntitys = [testGoodsEntitys copy];
        
        self.orderDetailsEntity = orderDetailsEntity; // self. KVO
        [self.refreshUISubject sendNext:orderDetailsEntity];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"orderId"] = self->_orderId;
                [networkMgr POST:kOrderDetialsQueryURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                    [subscriber sendCompleted];
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
