//
//  FMGoodsDetailsViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsViewModel.h"

@implementation FMGoodsDetailsViewModel

- (void)fm_initialize {
    @weakify(self)
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        if (! [resultModel.statusCode isEqualToString:@"OK"]) {
            self.detailsModel = nil;
            [self.refreshUISubject sendNext:nil];
            return;
        }
        FMGoodsDetailsModel * goodsDetailsModel = [FMGoodsDetailsModel mj_objectWithKeyValues:resultModel.jsonDict[@"goodsDetailsModel"]];
        self.detailsModel = goodsDetailsModel;
        [self.refreshUISubject sendNext:goodsDetailsModel];
    }];
}

#pragma mark - Lazyload

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *goodsId) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSDictionary *params = @{@"goodsId": goodsId ?: @(0)};
                [networkMgr GET:kQueryGoodsDetailsURIPath params:params success:^(NetworkResultModel *resultModel) {
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

- (RACSubject *)refreshUISubject {
    if (!_refreshUISubject) {
        _refreshUISubject = [[RACSubject alloc] init];
    }
    return _refreshUISubject;
}

- (RACSubject *)actionSubject {
    if (!_actionSubject) {
        _actionSubject = [[RACSubject alloc] init];
    }
    return _actionSubject;
}

@end
