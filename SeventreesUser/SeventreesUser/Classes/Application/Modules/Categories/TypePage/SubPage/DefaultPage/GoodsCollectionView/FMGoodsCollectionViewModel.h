//
//  FMGoodsCollectionViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMHomeGoodsModel.h"

@interface FMGoodsCollectionViewModel : FMViewModel

@property (nonatomic, copy) NSArray<FMHomeGoodsModel *> *goodsEntitys;

/** 网络请求参数： 1 商品列表 , 2 运营品牌列表 */
@property (nonatomic, copy) NSString * _Nonnull type;

@property (nonatomic, strong) RACCommand *requestDataCommand;
@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *selectItemSubject;
@property (nonatomic, strong) RACSubject *addShopCarSubject;

@end
