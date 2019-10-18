//
//  FMHomeViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeViewModel.h"

@implementation FMHomeViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            DLog(@"请求失败，接口错误！statusCode == %@", resultModel.statusCode);
            self.homeModel = nil;
            [self.refreshUISubject sendNext:nil];
            return;
        }
        
        FMHomeModel *homeModel = [FMHomeModel mj_objectWithKeyValues:resultModel.jsonDict];
        //            homeModel.goodsArray = [FMHomeGoodsModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"groups"][@"goods"]];
        /// 手动处理轮播图片数组
        NSMutableArray *mPictureURLStrs = [[NSMutableArray alloc] initWithCapacity:6];
        for (FMHomeCarouselModel *carouselModel in homeModel.carouselModels) {
            [mPictureURLStrs addObject:carouselModel.picUrl];
        }
        homeModel.pictureURLStrings = [mPictureURLStrs copy];
        
        /// 手动处理店铺信息模型
        FMHomeStoreModel *storeModel = [[FMHomeStoreModel alloc] init];
        storeModel.shopLogo = homeModel.shopLogo;
        storeModel.guideName = homeModel.guideName;
        storeModel.shopName = homeModel.shopName;
        storeModel.distance = homeModel.distance;
        storeModel.guideId = homeModel.guideId;
        storeModel.brandName = homeModel.brandName;
        homeModel.storeModel = storeModel;
        
        self.homeModel = homeModel;
        DLog(@"homeModel = %@", homeModel);
        
        [self.refreshUISubject sendNext:homeModel];
    }];
}

#pragma mark - Lazyload

- (RACSubject *)refreshSubject {
    if (! _refreshSubject) {
        _refreshSubject = [RACSubject subject];
    }
    return _refreshSubject;
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [networkMgr requestHomeListDataWithLongitude:@"41.1409530000" latitude:@"123.0140080000" success:^(NetworkResultModel *resultModel) {
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
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

- (RACSubject *)nextActionSubject {
    if (! _nextActionSubject) {
        _nextActionSubject = [RACSubject subject];
    }
    return _nextActionSubject;
}

@end
