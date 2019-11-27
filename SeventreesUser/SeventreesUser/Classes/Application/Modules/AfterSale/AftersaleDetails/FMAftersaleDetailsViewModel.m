//
//  FMAftersaleDetailsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAftersaleDetailsViewModel.h"

@implementation FMAftersaleDetailsViewModel

@synthesize requestDataCommand = _requestDataCommand;
@synthesize showHintSubject = _showHintSubject;

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        FMAftersaleDetailsModel *refundEntity = [FMAftersaleDetailsModel mj_objectWithKeyValues:resultModel.jsonDict];

        /// 自定义的退款订单说明实体
        FMRefundExplainModel *explainEntity = [[FMRefundExplainModel alloc] init];
        
        explainEntity.reason = refundEntity.reason;
        explainEntity.amount = refundEntity.amount;
        explainEntity.createdDateTime = refundEntity.createdDateTime;
        explainEntity.serialNumber = refundEntity.serialNumber;
        explainEntity.district = refundEntity.district;
        explainEntity.logisticsCompany = refundEntity.logisticsCompany;
        
        refundEntity.explainEntity = explainEntity;
        
        
        /// test goodsEntitys
        NSMutableArray *testGoodsEntitys = [[NSMutableArray alloc] init];
        for (NSUInteger idx = 0; idx != 3; idx++) {
            FMRefundGoodsModel *goodsEntity = [[FMRefundGoodsModel alloc] init];
            goodsEntity.skuId = @(2);
            goodsEntity.goodsId = @(16);
            goodsEntity.goodsNum = @(idx);
            goodsEntity.goodsPrice = @(99.80);
            goodsEntity.goodsName = [@"humana奶粉_67年德国品质积累_值得妈妈信赖 humana值得妈妈信赖" stringByAppendingString:@(idx).stringValue];
            goodsEntity.goodsImage = @"http://i1.sinaimg.cn/ent/d/2008-06-04/U105P28T3D2048907F326DT20080604225106.jpg";
            [testGoodsEntitys addObject:goodsEntity];
        }
        refundEntity.goodsEntitys = [testGoodsEntitys copy];
        
        self.refundEntity = refundEntity; // self. KVO
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
                params[@"afterSalesId"] = self->_refundId;
                [networkMgr POST:kAfterSalesDetailsQueryURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    @strongify(self)    [self.showHintSubject sendNext:error.localizedDescription];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}
@end
