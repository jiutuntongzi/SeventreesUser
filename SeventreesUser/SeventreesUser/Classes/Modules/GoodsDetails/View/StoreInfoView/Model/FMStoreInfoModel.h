//
//  FMStoreInfoModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMStoreInfoModel : FMModel

@property (nonatomic, strong) NSNumber *brandId;

@property (nonatomic, strong) NSNumber *brandGoodsNum;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, copy) NSString *brandContent;

@property (nonatomic, copy) NSString *brandImg;

@end

