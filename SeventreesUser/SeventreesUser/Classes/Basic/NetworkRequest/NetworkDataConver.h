//
//  NetworkDataConver.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkResultModel;

@interface NetworkDataConver : NSObject

+ (NetworkResultModel *)resultModelFromAFNetworkingResponseObject:(id _Nullable)responseObject;

@end
