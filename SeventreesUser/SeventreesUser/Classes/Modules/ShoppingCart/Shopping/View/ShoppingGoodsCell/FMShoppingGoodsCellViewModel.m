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
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        
        NSNumber *goodsNum = resultModel.jsonDict[@"goodsNum"];
        self->_goodsEntity.goodsNum = goodsNum.unsignedIntegerValue;
        [self.updateCountUISubject sendNext:goodsNum];
    }];
}

- (BOOL)checkRequestParams {
    BOOL (^checkParamsCallback)(NSNumber *, NSInteger) = ^(NSNumber *shoppingCarId, NSInteger goodsNum) {
        if (shoppingCarId == nil || goodsNum == 0) return NO;
        return YES;
    };
    BOOL isCheckOK = checkParamsCallback(self->_goodsEntity.shoppingCarId, self->_goodsEntity.goodsNum);
    return isCheckOK;
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                
                if ([self checkRequestParams] == NO) {
                    [self.showHintSubject sendNext:@"网络请求参数错误！"];
                    return nil;
                }
                NSDictionary *params = @{
                                         @"id": self->_goodsEntity.shoppingCarId,
                                         @"goodsNum": @(self->_goodsEntity.goodsNum)
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
