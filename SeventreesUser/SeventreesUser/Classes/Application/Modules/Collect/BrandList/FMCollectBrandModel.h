//
//  FMCollectBrandModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMCollectBrandModel : FMModel

@property (nonatomic, copy) NSString *logoUrl;

@property (nonatomic, strong) NSNumber *brandId;

@property (nonatomic, strong) NSNumber *num;

@property (nonatomic, copy) NSString *name;

/** 品牌描述 */
@property (nonatomic, copy) NSString *brandContent;

@end
