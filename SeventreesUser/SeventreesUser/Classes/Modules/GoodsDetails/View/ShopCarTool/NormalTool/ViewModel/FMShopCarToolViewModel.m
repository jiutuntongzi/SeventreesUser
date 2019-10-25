//
//  FMShopCarToolViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMShopCarToolViewModel.h"

@implementation FMShopCarToolViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestJoinCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
//        NSNumber *goodsId = resultModel.jsonDict[@"id"];
        [self.refreshUISubject sendNext:resultModel];
    }];
}

- (BOOL)checkRequestParams {
    BOOL (^checkParamsCallback)(NSNumber *, NSNumber *, NSInteger) = ^(NSNumber *goodsId, NSNumber *skuId, NSInteger goodsNum) {
        if (!goodsId || !skuId || goodsNum == 0) return NO;
        return YES;
    };
    
    BOOL isCheckOK = checkParamsCallback(self->_goodsParamsEntity.goodsId, self->_goodsParamsEntity.skuId, self->_goodsParamsEntity.goodsNum);
    [self.showHintSubject sendNext:@"网络请求参数错误！"];
    return isCheckOK;
}

#pragma mark - Lazyload

- (RACCommand *)requestJoinCommand {
    if (! _requestJoinCommand) {
        _requestJoinCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                if ([self checkRequestParams] == NO) return nil;
                
                NSDictionary *params = [self.goodsParamsEntity mj_keyValues];
                [networkMgr POST:kShoppingAddGoodsURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestJoinCommand;
}

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [[RACSubject alloc] init];
    }
    return _refreshUISubject;
}

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [[RACSubject alloc] init];
    }
    return _showHintSubject;
}

@end
