//
//  FMShoppingViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMShoppingGoodsModel.h"

@interface FMShoppingViewModel : FMViewModel

@property (nonatomic, copy) NSArray <FMShoppingGoodsModel *> *shoppingGoodsEntitys;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *goodsDetailsVCSubject;

@property (nonatomic, strong) RACSubject *settleAccountsVCSubject;

@end

