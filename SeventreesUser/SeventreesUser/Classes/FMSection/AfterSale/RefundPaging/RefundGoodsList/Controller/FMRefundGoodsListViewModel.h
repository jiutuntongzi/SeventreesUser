//
//  FMRefundGoodsListViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMRefundGoodsListViewModel : FMViewModel

@property (nonatomic, strong) id goodsList;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@end

