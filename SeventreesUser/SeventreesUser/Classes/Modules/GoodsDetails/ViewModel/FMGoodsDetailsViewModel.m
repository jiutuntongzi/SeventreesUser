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
        @strongify(self)    if (! self) return;
        if (! [resultModel.statusCode isEqualToString:@"OK"]) {
            self->_detailsModel = nil;
            [self.refreshUISubject sendNext:nil];
            return;
        }
        
        FMGoodsDetailsModel *goodsDetailsModel = [FMGoodsDetailsModel mj_objectWithKeyValues:resultModel.jsonDict[@"goodsDetailsModel"]];
        
        FMStoreInfoModel *storeInfoModel = [[FMStoreInfoModel alloc] init];
        storeInfoModel.brandId = goodsDetailsModel.brandId;
        storeInfoModel.brandGoodsNum = goodsDetailsModel.brandGoodsNum;
        storeInfoModel.brandName = goodsDetailsModel.brandName;
        storeInfoModel.brandContent = goodsDetailsModel.brandContent;
        storeInfoModel.brandImg = goodsDetailsModel.brandImg;
        
        goodsDetailsModel.storeModel = storeInfoModel;
        
        goodsDetailsModel.ordinaryGoodsMsg.goodsName = goodsDetailsModel.goodsName;
        
        NSMutableArray *mImageURLStrings = [NSMutableArray array];
        for (FMGoodsDetailsImagesModel *goodsPictureModel in goodsDetailsModel.detailsImages) {
            [mImageURLStrings addObject:goodsPictureModel.url];
        }
        goodsDetailsModel.imageURLStrings = [mImageURLStrings copy];
        
        FMShopCarToolModel *goodsParamsEntity = [[FMShopCarToolModel alloc] init];
        goodsParamsEntity.goodsId = goodsDetailsModel.goodsId;
        goodsParamsEntity.skuId = goodsDetailsModel.goodsSkuModels.firstObject.ID; // test
        goodsParamsEntity.goodsNum = 1;
        goodsDetailsModel.goodsParamsEntity = goodsParamsEntity;
        
        self->_detailsModel = goodsDetailsModel;
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

- (RACSubject *)nextActionSubject {
    if (! _nextActionSubject) {
        _nextActionSubject = [[RACSubject alloc] init];
    }
    return _nextActionSubject;
}

- (RACSubject *)nextBrandVCSubject {
    if (! _nextBrandVCSubject) {
        _nextBrandVCSubject = [[RACSubject alloc] init];
    }
    return _nextBrandVCSubject;
}

@end
