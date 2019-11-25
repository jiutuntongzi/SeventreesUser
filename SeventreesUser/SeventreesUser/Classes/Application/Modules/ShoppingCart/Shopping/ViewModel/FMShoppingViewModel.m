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
    
    [self.checkedActionSubject subscribeNext:^(id x) {
        @strongify(self)    if (!self) return;
        
        CGFloat totalPrice = 0.f;     NSUInteger goodsTotal = 0;    NSUInteger checkedCount = 0;
        
        for (FMShoppingGoodsModel *goodsEntity in self->_shoppingGoodsEntitys) {
            if (goodsEntity.isChecked) {
                totalPrice = goodsEntity.goodsPrice.floatValue * (CGFloat)goodsEntity.goodsNum;
                goodsTotal += goodsEntity.goodsNum;
                ++checkedCount;
            }
        }
        self.isCheckedAll = checkedCount > 0 && checkedCount == self->_shoppingGoodsEntitys.count;
        self.totalPrice = totalPrice;
        self.goodsTotal = goodsTotal;
        
        [self.refreshUISubject sendNext:self->_shoppingGoodsEntitys];
    }];
    
    [self.checkAllActionSubject subscribeNext:^(NSNumber *isCheckedAll) {
        @strongify(self)    if (!self) return;
        
        for (FMShoppingGoodsModel *goodsEntity in self.shoppingGoodsEntitys) {
            goodsEntity.isChecked = isCheckedAll.boolValue;
        };
        [self.checkedActionSubject sendNext:nil];
    }];
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        NSArray <FMShoppingGoodsModel *> *shoppingGoodsEntitys = [[FMShoppingGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        
        /// 取出先前列表商品的选中状态
        for (NSUInteger idx = 0; idx != self->_shoppingGoodsEntitys.count; idx++) {
            FMShoppingGoodsModel *goodsEntity = self->_shoppingGoodsEntitys[idx];
            for (FMShoppingGoodsModel *nowGoodsEntity in shoppingGoodsEntitys) {
                if (goodsEntity.shoppingCarId.integerValue == nowGoodsEntity.shoppingCarId.integerValue) {
                    nowGoodsEntity.isChecked = goodsEntity.isChecked;
                }
            }
        }
        self->_shoppingGoodsEntitys = shoppingGoodsEntitys;
        
        [self.checkedActionSubject sendNext:nil];
        [self.refreshUISubject sendNext:self->_shoppingGoodsEntitys];
    }];
    
    [self.requestDeleteGoodsCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"从购物车移除成功"];
        [self.requestDataCommand execute:nil]; // 删除商品成功后刷新列表
    }];
}

- (BOOL)verifyIsOK {
    /// 列表有无商品
    if (self->_shoppingGoodsEntitys.count == 0) {
        [self.showHintSubject sendNext:@"购物车无商品，请添加！"];
        return NO;
    }
    
    /// 是否有一个商品是选中的
    NSUInteger idx = 0;     BOOL hasChecked = NO;
    while (idx != self->_shoppingGoodsEntitys.count) {
        FMShoppingGoodsModel *goodsEntity = self->_shoppingGoodsEntitys[idx++];
        if (goodsEntity.isChecked) {
            hasChecked = YES;
            break;
        }
    }
    if (!hasChecked) {
        [self->_showHintSubject sendNext:@"未选中商品！"];
        return NO;
    }
    
    return YES;
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
//                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACCommand *)requestDeleteGoodsCommand {
    if (! _requestDeleteGoodsCommand) {
        _requestDeleteGoodsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSMutableArray<NSDictionary *> *shoppingGoodsIds = [NSMutableArray array];
                for (FMShoppingGoodsModel *goodsEntity in self->_shoppingGoodsEntitys) {
                    if (!goodsEntity.isChecked) continue;
                    if (goodsEntity.shoppingCarId) {
                        NSMutableDictionary *goodsIdDict = [NSMutableDictionary dictionary];
                        goodsIdDict[@"id"] = goodsEntity.shoppingCarId;
                        [shoppingGoodsIds addObject:[goodsIdDict copy]];
                    }
                }
                if (!shoppingGoodsIds.count) {
                    [self.showHintSubject sendNext:@"网络请求参数错误：shoppingCarId字段空了！"];
                    [subscriber sendCompleted];
                    return nil;
                }
                
                NSDictionary *params = @{@"apiPmShoppingCarts": [shoppingGoodsIds copy]};
                [networkMgr POST:kShoppingDeleteListToURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
//                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestDeleteGoodsCommand;
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

- (RACSubject *)checkAllActionSubject {
    if (! _checkAllActionSubject) {
        _checkAllActionSubject = [[RACSubject alloc] init];
    }
    return _checkAllActionSubject;
}

@end
