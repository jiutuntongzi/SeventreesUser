//
//  FMModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FMModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

