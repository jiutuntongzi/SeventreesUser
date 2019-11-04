//
//  FMMeViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/1.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMeViewModel.h"

@implementation FMMeViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        
        FMMeModel *profileEntity = [FMMeModel mj_objectWithKeyValues:resultModel.jsonDict];
        self->_profileEntity = profileEntity;
        
        // 转换成个人资料项数组cellItems
        NSMutableArray *profileItems = [[NSMutableArray alloc] initWithCapacity:4];
        FMPersonalInfoModel *itemModel0 = [[FMPersonalInfoModel alloc] init];
        {
            itemModel0.title = @"昵称";   itemModel0.subTitle = profileEntity.nick ?: @"请设置昵称";
            itemModel0.hasText = profileEntity.nick != nil;
        }
        FMPersonalInfoModel *itemModel1 = [[FMPersonalInfoModel alloc] init];
        {
            itemModel1.title = @"姓名";    itemModel1.subTitle = profileEntity.name ?: @"请填写姓名";
            itemModel1.hasText = profileEntity.name != nil;
        }
        FMPersonalInfoModel *itemModel2 = [[FMPersonalInfoModel alloc] init];
        {
            itemModel2.title = @"生日";    itemModel2.subTitle = profileEntity.birthday ?: @"请设置生日";
            itemModel2.hasText = profileEntity.birthday != nil;
        }
        FMPersonalInfoModel *itemModel3 = [[FMPersonalInfoModel alloc] init];
        {
            itemModel3.title = @"性别";
            NSString *sex = @"请选择性别";
            if (profileEntity.sex.length) {
                if (profileEntity.sex.integerValue == 1) {
                    sex = @"男";
                } else if (profileEntity.sex.integerValue == 2) {
                    sex = @"女";
                }
            }
            itemModel3.subTitle = sex;
            itemModel3.hasText = profileEntity.sex != nil;
        }
        [profileItems addObject:itemModel0];
        [profileItems addObject:itemModel1];
        [profileItems addObject:itemModel2];
        [profileItems addObject:itemModel3];
        self->_profileItems = [profileItems copy];
        [self.refreshUISubject sendNext:profileEntity];
    }];
    
    [self.requestUpdateDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)    if (!self) return;
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [self.showHintSubject sendNext:resultModel.statusMsg];
            return;
        }
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [SVProgressHUD dismissWithDelay:1.f];
        [self.requestDataCommand execute:nil]; // 刷新个人资料页面
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *couponId) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [networkMgr POST:kPersonalProfileQueryURIPath params:nil success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                    @strongify(self) [self.showHintSubject sendNext:error.localizedDescription];
                }];
                return nil;
            }];
        }];
    }
    return _requestDataCommand;
}

- (RACCommand *)requestUpdateDataCommand {
    if (! _requestUpdateDataCommand) {
        @weakify(self)
        _requestUpdateDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSMutableDictionary *params) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                self.bodyUpdateParams = params;
                [networkMgr POST:kPersonalProfileUpdateURIPath params:params success:^(NetworkResultModel *resultModel) {
                    [subscriber sendNext:resultModel];
                    [subscriber sendCompleted];
                    
                } failure:^(NSError *error) {
                    [subscriber sendCompleted];
                    @strongify(self) [self.showHintSubject sendNext:error.localizedDescription];
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

- (RACSubject *)showAddressVCSubject {
    if (! _showAddressVCSubject) {
        _showAddressVCSubject = [RACSubject subject];
    }
    return _showAddressVCSubject;
}

- (RACSubject *)showHintSubject {
    if (! _showHintSubject) {
        _showHintSubject = [RACSubject subject];
    }
    return _showHintSubject;
}


- (FMPersonalInfoModel *)itemInfoForIndex:(NSUInteger)index {
    if (! _profileItems) {
        NSString * const title = @"title";
        NSString * const subTitle = @"subTitle";
        
        NSMutableArray *_selectItems = [[NSMutableArray alloc] initWithCapacity:6];
        NSDictionary *selectItmes = @{
                                      @(0) : @{
                                              title           : @"昵称",
                                              subTitle        : @"请设置昵称",
                                              },
                                      @(1) : @{
                                              title           : @"姓名",
                                              subTitle        : @"请填写姓名",
                                              },
                                      @(2) : @{
                                              title           : @"生日",
                                              subTitle        : @"请设置生日",
                                              },
                                      @(3) : @{
                                              title           : @"性别",
                                              subTitle        : @"请选择性别",
                                              },
                                      };
        for (NSUInteger idx = 0; idx != selectItmes.count; idx ++) {
            NSDictionary *infoItem = selectItmes[@(idx)];
            [_selectItems addObject:[[FMPersonalInfoModel alloc] initWithDict:infoItem]];
        }
        _profileItems = [_selectItems copy];
    }
    return _profileItems[index];
}

@end
