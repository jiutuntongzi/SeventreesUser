//
//  NetworkResultModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "NetworkResultModel.h"

@implementation NetworkResultModel

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>",
            [self class], self,
            @{
              @"statusCode": _statusCode,
              @"statusMsg": _statusMsg,
              @"jsonDict": _jsonDict,
              @"jsonString": _jsonString
              }];
}

@end
