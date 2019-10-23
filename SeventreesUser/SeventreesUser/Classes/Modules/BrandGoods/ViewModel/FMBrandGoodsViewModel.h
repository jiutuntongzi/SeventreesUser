//
//  FMBrandGoodsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMBrandModel.h"

@interface FMBrandGoodsViewModel : FMViewModel

@property (nonatomic, strong) FMBrandModel *brandModel;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;


@property (nonatomic, strong) RACSubject *goodsDetailsVCSubject;

@property (nonatomic, strong) RACSubject *shopCarVCSubject;

@end
