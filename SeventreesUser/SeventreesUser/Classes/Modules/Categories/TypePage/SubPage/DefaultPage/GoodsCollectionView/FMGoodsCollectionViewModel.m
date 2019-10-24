//
//  FMGoodsCollectionViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsCollectionViewModel.h"

@implementation FMGoodsCollectionViewModel

- (void)fm_initialize {
    self->_type = @"2";
    
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
        NSArray<FMHomeGoodsModel *> *goodsEntitys = [[FMHomeGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        self->_goodsEntitys = goodsEntitys;
        [self.refreshUISubject sendNext:goodsEntitys];
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self);
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                if (self->_type.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"数据错误：type空了！"];
                    return nil;
                }
                [networkMgr POST:kQueryCollectListURIPath params:@{@"type": self->_type} success:^(NetworkResultModel *resultModel) {
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

- (RACSubject *)selectItemSubject {
    if (! _selectItemSubject) {
        _selectItemSubject = [[RACSubject alloc] init];
    }
    return _selectItemSubject;
}

- (RACSubject *)addShopCarSubject {
    if (! _addShopCarSubject) {
        _addShopCarSubject = [[RACSubject alloc] init];
    }
    return _addShopCarSubject;
}

@end
