//
//  FMSettlementViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMSettlementViewModel : FMViewModel

@property (nonatomic, assign) NSUInteger checkedGoodsTotal;

@property (nonatomic, assign) CGFloat totalPrice;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, assign) BOOL isCheckedAll;

@property (nonatomic, strong) RACSubject *checkAllActionSubject;

@property (nonatomic, strong) RACSubject *settleActionSubject;

@property (nonatomic, strong) RACSubject *deleteActionSubject;

@end
