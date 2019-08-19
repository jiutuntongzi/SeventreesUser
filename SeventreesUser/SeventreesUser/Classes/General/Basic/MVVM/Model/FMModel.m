//
//  FMModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@implementation FMModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}
    
@end
