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

@property (nonatomic, copy) NSArray<FMCollectBrandModel *> *brandEntitys;

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

/** 网络请求参数： 1 商品列表 , 2 品牌列表 */
@property (nonatomic, copy) NSString * _Nonnull type;

@property (nonatomic, strong) RACCommand *requestBrandDataCommand;

@property (nonatomic, strong) RACSubject *refreshBrandUISubject;

@end

