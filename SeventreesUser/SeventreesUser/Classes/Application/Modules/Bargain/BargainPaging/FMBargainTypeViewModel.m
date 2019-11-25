//
//  FMBargainTypeViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/22.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBargainTypeViewModel.h"

@implementation FMBargainTypeViewModel

- (void)fm_initialize {
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        /// test
        FMBargainItemModel *categoryEntity = [[FMBargainItemModel alloc] init];
        categoryEntity.categoryId = @(1);
        categoryEntity.name = @"测试分类";
        self.itemEntitys = @[categoryEntity, categoryEntity, categoryEntity];
        
        /*
        self.itemEntitys = [FMBargainItemModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]];
        */
        [self.refreshUISubject sendNext:self->_itemEntitys];
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *goodsId) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
                params[@"type"] = self->_activityType;
                [networkMgr POST:kBargainCategoryQueryURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [[RACSubject alloc] init];
    }
    return _showHintSubject;
}

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [[RACSubject alloc] init];
    }
    return _refreshUISubject;
}

@end
