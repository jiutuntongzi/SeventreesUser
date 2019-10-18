//
//  FMGoodsDetailsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMGoodsDetailsModel.h"

@interface FMGoodsDetailsViewModel : FMViewModel

/** 商品ID，从外边传进来的，用作商品详情网络请求参数 */
@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, strong) FMGoodsDetailsModel *detailsModel;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *actionSubject;

@end
