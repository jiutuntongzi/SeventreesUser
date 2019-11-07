//
//  FMGoodsCellViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMHomeGoodsModel.h"

@interface FMGoodsCellViewModel : FMViewModel

@property (nonatomic, strong) FMHomeGoodsModel *goodsModel;

@property (nonatomic, strong) RACSubject *selectActionSubject;

@property (nonatomic, strong) RACSubject *addActionSubject;

@end
