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
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        // NSNumber *goodsId = resultModel.jsonDict[@"id"];
//        [self.showHintSubject sendNext:@"加入商品成功"];
        [SVProgressHUD showSuccessWithStatus:@"加入商品成功"];
    }];
    
    [self.requestCollectCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        if (!resultModel.isSuccess) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        self->_isCollect = !self->_isCollect;
        [self.refreshUISubject sendNext:resultModel];
//        self->_isCollect = @(!self->_isCollect.boolValue);
    }];
}

- (BOOL)checkOKRequestParams {
    BOOL (^checkParamsCallback)(NSNumber *, NSNumber *, NSInteger) = ^(NSNumber *goodsId, NSNumber *skuId, NSInteger goodsNum) {
        if (!goodsId || !skuId || goodsNum == 0) return NO;
        return YES;
    };
    
    BOOL isCheckOK = checkParamsCallback(self->_goodsParamsEntity.goodsId, self->_goodsParamsEntity.skuId, self->_goodsParamsEntity.goodsNum);
    if (isCheckOK == NO) [self.showHintSubject sendNext:@"网络请求参数错误！"];
    return isCheckOK;
}

- (BOOL)checkOKRequestCollectParams {
    if (!self->_goodsParamsEntity.goodsId || !self->_goodsParamsEntity.brandId) {
        [self.showHintSubject sendNext:@"网络请求参数错误！"];
        return NO;
    }
    return YES;
}

#pragma mark - Lazyload

- (RACCommand *)requestJoinCommand {
    if (! _requestJoinCommand) {
        _requestJoinCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)

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

- (RACCommand *)requestCollectCommand {
    if (! _requestCollectCommand) {
        _requestCollectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self)
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                
                NSDictionary *params = @{@"goodsId": self.goodsParamsEntity.goodsId, @"brandId": self.goodsParamsEntity.brandId};
                [networkMgr POST:kCollectAddGoodsURIPath params:params success:^(NetworkResultModel *resultModel) {
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
    return _requestCollectCommand;
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
