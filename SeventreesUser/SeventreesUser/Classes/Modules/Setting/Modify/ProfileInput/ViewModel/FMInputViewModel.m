//
//  FMInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMInputViewModel.h"

@implementation FMInputViewModel

- (void)fm_initialize {
    @weakify(self)
    
    self.inputModel.bindPhoneNumber = userData().phoneNumber;
    
    [self.requestUpdateDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:resultModel.jsonDict[@"data"]];
        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (RACCommand *)requestUpdateDataCommand {
    if (! _requestUpdateDataCommand) {
        @weakify(self)
        _requestUpdateDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSMutableDictionary *params) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

                
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
                params[@"moblie"] = self.inputModel.phoneNumber;
                params[@"code"] = self.inputModel.verifyCode;
                params[@"newMobile"] = self.inputModel.twoPhoneNumber;
                params[@"password"] = self.inputModel.password;
                
                /// 移除空值对应的字典元素(key->value)
                NSMutableArray *removeKeys = [[NSMutableArray alloc] initWithCapacity:3];
                [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    if (obj == nil) [removeKeys addObject:key];
                }];
                [params removeObjectsForKeys:removeKeys];
                
                [networkMgr POST:kUpdateByCodeURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    @strongify(self) [self.showHintSubject sendNext:error.localizedDescription];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _requestUpdateDataCommand;
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

- (RACSubject *)nextPageSubject {
    if (!_nextPageSubject) {
        _nextPageSubject = [[RACSubject alloc] init];
    }
    return _nextPageSubject;
}

- (FMInputModel *)inputModel {
    if (! _inputModel) {
        _inputModel = [[FMInputModel alloc] init];
    }
    return _inputModel;
}

@end
