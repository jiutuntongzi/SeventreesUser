//
//  FMScoreViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreViewModel.h"

@implementation FMScoreViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.refreshUISubject subscribeNext:^(id x) {
        [self.requestDataCommand execute:nil];
    }];
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
//        self.scoreEntitys = [FMScoreRecordModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]];
        
        /// test
        NSDictionary *itemEntity = @{
                                     @"extra": @{},
                                     @"id": @(2),
                                     @"dr": @"N",
                                     @"createdDateTime": @"2019-09-16 17:08:58",  // --时间
                                     @"titile": @"每日签到",        //--标题
                                     @"expendIntegral": @(2),       // --出入分数
                                     @"expendType": @(1),        //--1加 2减
                                     };
        FMScoreRecordModel *entity = [FMScoreRecordModel mj_objectWithKeyValues:itemEntity];
        [self.scoreEntitys addObjectsFromArray:@[entity, entity, entity, entity, entity,entity,entity,entity,entity]];
        [self.refreshRecordSubject sendNext:self.scoreEntitys];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
//        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
                params[@"limit"] = @(100);  // params[@"limit"] = @(_limit);
                params[@"page"] = @(1);     // params[@"page"] = @(_pageNo);
                [networkMgr POST:kIntegralRecordListQueryURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)refreshRecordSubject {
    if (! _refreshRecordSubject) {
        _refreshRecordSubject = [RACSubject subject];
    }
    return _refreshRecordSubject;
}

- (RACSubject *)nextPageSubject {
    if (! _nextPageSubject) {
        _nextPageSubject = [[RACSubject alloc] init];
    }
    return _nextPageSubject;
}

- (NSMutableArray<FMScoreRecordModel *> *)scoreEntitys {
    if (! _scoreEntitys) {
        _scoreEntitys = [NSMutableArray array];
    }
    return _scoreEntitys;
}

@end
