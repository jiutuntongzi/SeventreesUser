//
//  FMShoppingViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShoppingViewModel.h"

@implementation FMShoppingViewModel

- (void)fm_initialize {
    
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        
        self->_shoppingGoodsEntitys = [FMShoppingGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]];
        
        [self.refreshUISubject sendNext:self->_shoppingGoodsEntitys];
    }];
    
    [self.checkedActionSubject subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
        CGFloat totalPrice = 0.f;     NSUInteger goodsTotal = 0; NSUInteger checkedCount = 0;
        
        for (FMShoppingGoodsModel *goodsEntity in self->_shoppingGoodsEntitys) {
            if (goodsEntity.isChecked) {
                totalPrice = goodsEntity.goodsPrice.floatValue * (CGFloat)goodsEntity.goodsNum;
                goodsTotal += goodsEntity.goodsNum;
                ++checkedCount;
            }
        }
        
        self.totalPrice = totalPrice;
        self.goodsTotal = goodsTotal;
        if (checkedCount == self->_shoppingGoodsEntitys.count) {
            self.isCheckedAll = YES;
        }
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [networkMgr POST:kShoppingQueryGoodsListURIPath params:nil success:^(NetworkResultModel *resultModel) {
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

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)goodsDetailsVCSubject {
    if (! _goodsDetailsVCSubject) {
        _goodsDetailsVCSubject = [[RACSubject alloc] init];
    }
    return _goodsDetailsVCSubject;
}

- (RACSubject *)settleAccountsVCSubject {
    if (! _settleAccountsVCSubject) {
        _settleAccountsVCSubject = [[RACSubject alloc] init];
    }
    return _settleAccountsVCSubject;
}

- (RACSubject *)checkedActionSubject {
    if (! _checkedActionSubject) {
        _checkedActionSubject = [RACSubject subject];
    }
    return _checkedActionSubject;
}

@end
