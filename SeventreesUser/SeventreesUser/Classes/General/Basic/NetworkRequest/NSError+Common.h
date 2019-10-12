//
//  NSError+Common.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>

//domain
FOUNDATION_EXPORT NSString * const NSCommonErrorDomain;
/** 错误状态码 */
typedef NS_ENUM(NSInteger, NSCommonErrorCode){
    // Bad Request（由于语法格式有误，服务器无法理解此请求。不作修改，客户程序就无法重复此请求。）
    NSCommonErrorCodeFailed = 400,
    
    // Web 服务器找不到您所请求的文件或脚本。请检查URL以确保路径正确。
    NSCommonErrorCodeUnKnown = 404,
    
    // 服务器的内部错误Web。服务器不能执行此请求。请稍后重试此请求。
    NSCommonErrorCodeInternalServer = 500,
    
    // 没有连接到服务器
    NSCommonErrorCodeNotConnectServer = -1004,
    
    // 请求超时(The request timed out.)
    NSCommonErrorCodeRequestTimedOut = -1001,
};

@interface NSError (Common)

+ (NSError *)errorCode:(NSCommonErrorCode)code;

+ (NSError *)errorCode:(NSCommonErrorCode)code userInfo:(nullable NSDictionary *)userInfo;

@end
