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

/** 响应原始JSON数据 */
@property (nonatomic, copy) NSString *originalJSONString;

/** 响应字典数据 */
@property (nonatomic, strong) NSDictionary *dict;

@end
