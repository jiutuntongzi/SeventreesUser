//
//  NetworkResultModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkResultModel : NSObject

/** 状态码 */
@property (nonatomic, copy) NSString *statusCode;

/** 状态消息 */
@property (nonatomic, copy) NSString *statusMsg;

/** 响应原始JSON字符串 */
@property (nonatomic, copy) NSString *jsonString;

/** 响应JSON字典 */
@property (nonatomic, strong) NSDictionary *jsonDict;

@end
