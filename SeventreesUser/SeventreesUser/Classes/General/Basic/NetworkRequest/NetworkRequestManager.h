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
#import "NSError+Common.h"

/** 备用服(外网) */

typedef NS_ENUM(NSUInteger, NetworkRequestManagerServerType) {
    
    NetworkRequestManagerServerTypeFormal ,     // 0：主正式服 (线上)
    
    NetworkRequestManagerServerTypeTest,        // 1：测试服（内网/线下）
    
//    NetworkRequestManagerServerTypeStandby    // 2：备用服
};

typedef void(^NetworkRequestSuccess)(NetworkResultModel* resultModel);

typedef void(^NetworkRequestFailure)(NSError *error);


@interface NetworkRequestManager : NSObject

/** 网络请求管理单例 */
#define     networkMgr    [NetworkRequestManager shareNetworkRequestManager]
+ (instancetype)shareNetworkRequestManager;

/** 获取当前服务器类型  */
@property (nonatomic, readonly, assign) NetworkRequestManagerServerType requestHostType;

/** 切换服务器 (更换请求主域名)  */
- (void)changeRequestServerType:(NetworkRequestManagerServerType)requestHostType;


#pragma mark ——— AFURLSessionManager

- (void)GET:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)POST:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)cancelRequests;


#pragma mark ——— AFHTTPSessionManager

- (void)GET:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)POST:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)cancelRequestTasks;


#pragma mark ——— NSURLSession

- (void)POST:(NSString *)URLString success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

#pragma mark ——— Network API

- (void)requestLoginWithPhoneNumber:(NSString *)phoneNumber verifyCode:(NSString *)verifyCode password:(NSString *)password success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)requestHomeListDataWithLongitude:(NSString *)longitude latitude:(NSString *)latitude success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)requestFindGoodsOrBrandWithName:(NSString *)name success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

- (void)requestSearchGoodsName:(NSString *)goodsName categoryId:(NSInteger)categoryId activityType:(NSInteger)activityType sortMethod:(NSInteger)sortMethod sortSequence:(NSInteger)sortSequence pageNo:(NSInteger)pageNo limit:(NSInteger)limit success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

@end
