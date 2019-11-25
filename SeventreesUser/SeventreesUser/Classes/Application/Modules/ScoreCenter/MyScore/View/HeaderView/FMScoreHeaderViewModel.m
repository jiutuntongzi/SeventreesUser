//
//  FMScoreHeaderViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreHeaderViewModel.h"

@implementation FMScoreHeaderViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        self.scoreEntity = [FMScoreModel mj_objectWithKeyValues:resultModel.jsonDict]; // self. KVO
    }];
    
    [self.requestSignInCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"签到成功"];
        [self.requestDataCommand execute:nil]; // 重新加载积分头部
    }];
    
    [self.requestWebExplainCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        self->_webExplainURL = [resultModel.jsonDict[@"html"] copy];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        //        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //                @strongify(self)
                [networkMgr POST:kIntegralQueryURIPath params:nil success:^(NetworkResultModel *resultModel) {
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

- (RACCommand *)requestWebExplainCommand {
    if (! _requestWebExplainCommand) {
        //        @weakify(self)
        _requestWebExplainCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //                @strongify(self)
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
                params[@"type"] = @(1);
                [networkMgr POST:kIntegralExplainHTMLQueryURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestWebExplainCommand;
}

- (RACCommand *)requestSignInCommand {
    if (! _requestSignInCommand) {
        //        @weakify(self)
        _requestSignInCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //                @strongify(self)
                [networkMgr POST:kSignInIntegralURIPath params:nil success:^(NetworkResultModel *resultModel) {
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
    return _requestSignInCommand;
}

//- (RACSubject *)refreshUISubject {
//    if (! _refreshUISubject) {
//        _refreshUISubject = [RACSubject subject];
//    }
//    return _refreshUISubject;
//}

- (RACSubject *)nextPageSubject {
    if (! _nextPageSubject) {
        _nextPageSubject = [[RACSubject alloc] init];
    }
    return _nextPageSubject;
}

@end
