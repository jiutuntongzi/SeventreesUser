//
//  FMSlashDetailsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashDetailsViewModel.h"

@implementation FMSlashDetailsViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        self.slashEntity = [FMSlashDetailsModel mj_objectWithKeyValues:resultModel.jsonDict];
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

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [[RACSubject alloc] init];
    }
    return _showHintSubject;
}

@end
