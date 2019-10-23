//
//  FMBrandGoodsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMBrandGoodsViewModel.h"

@implementation FMBrandGoodsViewModel

- (void)fm_initialize {
    @weakify(self)

    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (! self) return;
        
        FMBrandModel *brandEntity = [FMBrandModel mj_objectWithKeyValues:resultModel.jsonDict];
        brandEntity.brandInfoEntity.goodsTotal = brandEntity.num;
        self->_brandModel = brandEntity;
        
        [self.refreshUISubject sendNext:brandEntity];
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *brandId) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSDictionary *params = @{@"brandId": brandId ?: @(0), @"page": @(1), @"limit": @(100)};
                [networkMgr POST:kQueryBrandInfoURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [[RACSubject alloc] init];
    }
    return _refreshUISubject;
}

- (RACSubject *)goodsDetailsVCSubject {
    if (! _goodsDetailsVCSubject) {
        _goodsDetailsVCSubject = [[RACSubject alloc] init];
    }
    return _goodsDetailsVCSubject;
}

- (RACSubject *)shopCarVCSubject {
    if (! _shopCarVCSubject) {
        _shopCarVCSubject = [[RACSubject alloc] init];
    }
    return _shopCarVCSubject;
}

@end
