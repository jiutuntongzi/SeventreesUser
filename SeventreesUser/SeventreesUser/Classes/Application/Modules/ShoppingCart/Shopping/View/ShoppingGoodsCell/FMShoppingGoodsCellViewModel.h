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

@property (nonatomic, strong) FMShoppingGoodsModel *goodsEntity;

/** lazy get */
@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *updateCountUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACSubject *checkedActionSubject;

@property (nonatomic, strong) RACSubject *addActionSubject;

@property (nonatomic, strong) RACSubject *minusActionSubject;

@property (nonatomic, strong) RACSubject *updateSettlementInfoSubject;

@end
