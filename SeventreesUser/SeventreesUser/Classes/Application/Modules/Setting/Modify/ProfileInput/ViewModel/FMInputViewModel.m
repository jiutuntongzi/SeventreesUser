//
//  FMInputViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMInputViewModel.h"

@implementation FMInputViewModel

- (void)setType:(FMInputViewType)type {
    _type = type;
    
    if (self.type == FMInputViewTypeModifyPassword || self.type == FMInputViewTypeBindStore) {
        self.inputModel.phoneNumber = userData().phoneNumber;
    } else {
        self.inputModel.phoneNumber = nil;
    }
}

- (void)fm_initialize {
    @weakify(self)
    
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
                
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:4];
                if (self.inputModel.phoneNumber.length == 11) {
                    params[@"moblie"] = [NSString stringWithFormat:@"%@,%lu", self.inputModel.phoneNumber, operationBrand];
                }
                if (self.inputModel.twoPhoneNumber.length == 11) {
                    params[@"newMobile"] = [NSString stringWithFormat:@"%@,%lu", self.inputModel.twoPhoneNumber, operationBrand];
                }
                params[@"password"] = self.inputModel.password;
                params[@"code"] = self.inputModel.verifyCode;
                
                /// 移除空值对应的字典元素(key->value)
                NSMutableArray *removeKeys = [[NSMutableArray alloc] initWithCapacity:4];
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
