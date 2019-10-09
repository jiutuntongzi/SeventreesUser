//
//  NetworkDataConver.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "NetworkDataConver.h"
#import "NetworkResultModel.h"
#import "MJExtension.h"

@implementation NetworkDataConver

+ (NetworkResultModel *)resultModelFromAFNetworkingResponseObject:(id _Nullable)responseObject {
    
    NetworkResultModel *resultModel = [[NetworkResultModel alloc] init];
    resultModel.statusMsg = responseObject[@"message"];
    resultModel.statusCode = responseObject[@"code"];
    resultModel.jsonDict = responseObject[@"response"];
    resultModel.jsonString = [resultModel.jsonDict mj_JSONString];
    
    return resultModel;
}

@end
