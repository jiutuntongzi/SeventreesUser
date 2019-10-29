//
//  FMCollectBrandListViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/17.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectBrandListViewModel.h"

@implementation FMCollectBrandListViewModel

- (void)fm_initialize {
    self->_type = @"2";
    
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
//        if (![resultModel.statusCode isEqualToString:@"OK"]) {
//            DLog(@"请求失败，接口错误！statusCode == %@", resultModel.statusCode);
//        }
        self->_brandEntitys = [FMCollectBrandModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"brandList"]];
        [self.refreshUISubject sendNext:resultModel];
    }];
    
    [self.requestBrandDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        
         self->_brandEntitys = [[FMCollectBrandModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        [self.refreshBrandUISubject sendNext:self->_brandEntitys];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
                params[@"brandName"] = self->_searchText ?: @"";
                [networkMgr POST:kHomeAueryBrandURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACCommand *)requestBrandDataCommand {
    if (! _requestBrandDataCommand) {
        @weakify(self);
        _requestBrandDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                if (self->_type.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"数据错误：type空了！"];
                    return nil;
                }
                [networkMgr POST:kCollectListQueryURIPath params:@{@"type": self->_type} success:^(NetworkResultModel *resultModel) {
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
    return _requestBrandDataCommand;
}

- (RACSubject *)refreshUISubject {
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)refreshBrandUISubject {
    if (! _refreshBrandUISubject) {
        _refreshBrandUISubject = [RACSubject subject];
    }
    return _refreshBrandUISubject;
}

@end
