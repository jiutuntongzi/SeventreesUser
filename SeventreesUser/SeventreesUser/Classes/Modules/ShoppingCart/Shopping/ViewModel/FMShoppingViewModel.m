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
        
        self->_shoppingGoodsEntitys = [FMShoppingGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict];
        [self.refreshUISubject sendNext:self->_shoppingGoodsEntitys];
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [networkMgr POST:kQueryShoppingListURIPath params:nil success:^(NetworkResultModel *resultModel) {
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



@end
