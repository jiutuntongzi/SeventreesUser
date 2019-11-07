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

@property (nonatomic, assign) CGFloat totalPrice;

@property (nonatomic, assign) NSUInteger goodsTotal;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, assign) BOOL isCheckedAll;


@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACCommand *requestDeleteGoodsCommand;


@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;


@property (nonatomic, strong) RACSubject *checkedActionSubject;

@property (nonatomic, strong) RACSubject *checkAllActionSubject;

@property (nonatomic, strong) RACSubject *goodsDetailsVCSubject;

@property (nonatomic, strong) RACSubject *settleAccountsVCSubject;

/** 请求验证：列表有商品、且至少有一个商品是选中的 */
- (BOOL)verifyIsOK;

@end

