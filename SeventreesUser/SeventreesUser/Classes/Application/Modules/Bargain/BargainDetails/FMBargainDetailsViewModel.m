//
//  FMBargainDetailsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainDetailsViewModel.h"

@implementation FMBargainDetailsViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        self.bargainDetailsEntity = [FMBargainDetailsModel mj_objectWithKeyValues:resultModel.jsonDict];
    }];
    
    [self.requestStartBargainCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        FMSlashInGoodsModel *goodsEntity = self->_bargainDetailsEntity.goodsEntitys.firstObject;
        RACTuple *tuple = [RACTuple tupleWithObjects:goodsEntity.goodsId, goodsEntity.activityId, nil];
        [self.nextVCSubject sendNext:tuple];
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
                params[@"activityId"] = self->_activityId;
                params[@"goodsId"] = self->_goodsId;
                [networkMgr POST:kActivityInfoURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACCommand *)requestStartBargainCommand {
    if (! _requestStartBargainCommand) {
        @weakify(self)
        _requestStartBargainCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id x) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
                params[@"activityId"] = self->_activityId;
                params[@"goodsId"] = self->_goodsId;
                params[@"skuId"] = self->_skuId;
                [networkMgr POST:kBargainCreateURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestStartBargainCommand;
}


- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [[RACSubject alloc] init];
    }
    return _showHintSubject;
}

- (RACSubject *)nextVCSubject {
    if (! _nextVCSubject) {
        _nextVCSubject = [[RACSubject alloc] init];
    }
    return _nextVCSubject;
}
@end
