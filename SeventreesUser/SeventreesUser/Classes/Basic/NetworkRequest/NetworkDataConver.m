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
#import "NSString+YYAdd.h"

@implementation NetworkDataConver

+ (NetworkResultModel *)resultModelFromAFNetworkingResponseObject:(id _Nullable)responseObject {
    if (!responseObject) return nil;
    
    NetworkResultModel *resultModel = [[NetworkResultModel alloc] init];
//    [string stringByURLDecode]
    
    resultModel.statusCode = responseObject[@"code"];
    resultModel.isSuccess = [resultModel.statusCode isEqualToString:@"OK"]; // test
    resultModel.statusMsg = responseObject[@"message"];
    resultModel.jsonDict = responseObject[@"response"];
    resultModel.jsonString = [responseObject mj_JSONString];
    return resultModel;
}

/** Unicode转汉字 */
+ (NSString *)replaceUnicode:(NSString *)unicodeString {
    NSString *tempStr1 = [unicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

@end
