//
//  FMShoppingGoodsCellViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMShoppingGoodsModel.h"

@interface FMShoppingGoodsCellViewModel : FMViewModel

@property (nonatomic, copy) FMShoppingGoodsModel *goodsEntity;

@property (nonatomic, strong) RACCommand *requestDataCommand; // get

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *updateCountUISubject;

@property (nonatomic, strong) RACSubject *checkedActionSubject;

@end
