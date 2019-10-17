//
//  FMCollectBrandListViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/17.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMCollectBrandModel.h"

@interface FMCollectBrandListViewModel : FMViewModel

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, copy) NSArray<FMCollectBrandModel *> *brandEntitys;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

