//
//  FMAnnouncementViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAnnouncementViewModel.h"

@implementation FMAnnouncementViewModel

- (void)fm_initialize {
    @weakify(self)
    
    [self.requestDataCommand.executionSignals.switchToLatest subscribeNext:^(NetworkResultModel *resultModel) {
        @strongify(self)
        if (! [resultModel.statusCode isEqualToString:@"OK"]) return;
        
        NSArray *announcementModels = [[FMAnnouncementModel mj_objectArrayWithKeyValuesArray:resultModel.jsonDict[@"data"]] copy];
        self->_announcementModels = announcementModels;
        
        NSMutableArray *mTitles = [NSMutableArray array];
        for (FMAnnouncementModel *announcementModel in announcementModels) {
            [mTitles addObject:announcementModel.title];
        }
        [self.refreshUISubject sendNext:[mTitles copy]];
    }];
}

- (RACCommand *)requestDataCommand {
    if (! _requestDataCommand) {
        //        @weakify(self)
        _requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //                @strongify(self)
                [networkMgr POST:kHomeSysnoticeURIPath params:nil success:^(NetworkResultModel *resultModel) {
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
    if (! _refreshUISubject) {
        _refreshUISubject = [RACSubject subject];
    }
    return _refreshUISubject;
}

@end
