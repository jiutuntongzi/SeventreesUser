//
//  FMShoppingGoodsCellViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingGoodsCellViewModel.h"

@implementation FMShoppingGoodsCellViewModel

- (void)fm_initialize {
    @weakify(self)
    
    _updateCountUISubject = [[RACSubject alloc] init];
    _showHintSubject = [[RACSubject alloc] init];
    _checkedActionSubject = [[RACSubject alloc] init];
    _addActionSubject = [[RACSubject alloc] init];
    _minusActionSubject = [[RACSubject alloc] init];
    _updateSettlementInfoSubject = [[RACSubject alloc] init];
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        
        if (!resultModel.isSuccess) {
            [self->_showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        NSNumber *goodsNum = resultModel.jsonDict[@"goodsNum"];
        self->_goodsEntity.goodsNum = goodsNum.unsignedIntegerValue;
        
        [self->_updateSettlementInfoSubject sendNext:nil];
        [self.updateCountUISubject sendNext:goodsNum];
    }];
}

- (BOOL)checkRequestParams:(NSNumber *)goodsNum {
    BOOL (^checkParamsCallback)(NSNumber *, NSUInteger) = ^(NSNumber *shoppingCarId, NSUInteger goodsNum) {
        if (shoppingCarId == nil || goodsNum == 0) return NO;
        return YES;
    };
    BOOL isCheckOK = checkParamsCallback(self->_goodsEntity.shoppingCarId, goodsNum.unsignedIntegerValue);
    return isCheckOK;
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *goodsNum) {
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                
                if ([self checkRequestParams:goodsNum] == NO) {
                    [self.showHintSubject sendNext:@"网络请求参数错误！"];
                    return nil;
                }
                NSDictionary *params = @{
                                         @"id": self->_goodsEntity.shoppingCarId,
                                         @"goodsNum": goodsNum
                                         };
                [networkMgr POST:kShoppingUpdateGoodsCountURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

@end
