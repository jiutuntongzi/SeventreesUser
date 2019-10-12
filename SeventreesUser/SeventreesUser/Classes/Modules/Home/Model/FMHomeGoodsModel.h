//
//  FMHomeGoodsModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMHomeGoodsModel : FMModel

@property (nonatomic, strong) NSNumber *ID;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *retailPrice;

@end

