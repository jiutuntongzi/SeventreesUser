//
//  NetworkRequestManager.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URIPath.h"
#import "NetworkResultModel.h"

typedef NS_ENUM(NSUInteger, NetworkRequestManagerServerType) {
    
    NetworkRequestManagerServerTypeFormal ,     // 0：主正式服 (线上)
    
    NetworkRequestManagerServerTypeTest,        // 1：测试服（内网/线下）
    
//    NetworkRequestManagerServerTypeStandby    // 2：备用服
};

typedef void(^NetworkRequestSuccess)(NetworkResultModel* resultModel);

typedef void(^NetworkRequestFailure)(NSError *error);


@interface NetworkRequestManager : NSObject

/** 网络请求管理单例 */
#define     NetworkMgr    [NetworkRequestManager shareNetworkRequestManager]
+ (instancetype)shareNetworkRequestManager;

/** 获取当前服务器类型  */
@property (nonatomic, readonly, assign) NetworkRequestManagerServerType requestHostType;

/** 切换服务器 (更换请求主域名)  */
- (void)changeRequestServerType:(NetworkRequestManagerServerType)requestHostType;

#pragma mark ——— AFURLSessionManager

- (void)GET:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)POST:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

#pragma mark ——— AFHTTPSessionManager

- (void)GET:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)POST:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

@end
