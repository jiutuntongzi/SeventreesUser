//
//  FMShoppingViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMShoppingGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMShoppingViewModel : FMViewModel

@property (nonatomic, strong) FMShoppingGoodsModel *shoppingGoodsModel;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;


@property (nonatomic, strong) RACSubject *ActionSubject;

@property (nonatomic, strong) RACSubject *settleActionSubject;

@end

NS_ASSUME_NONNULL_END
