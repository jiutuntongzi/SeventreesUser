//
//  NetworkRequestManager.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "NetworkRequestManager.h"
#import "AFNetworking.h"
#import "NetworkDataConver.h"
#import "UserData.h"
#import "DLogHeader.h"

typedef NS_ENUM(NSUInteger, HTTPRequestMethod){
    HTTPRequestMethodPOST = 0,
    HTTPRequestMethodGET,
    HTTPRequestMethodPUT,
    HTTPRequestMethodDELETE,
};

/** 主正式服 */
#define     kFormalHostDomain      @""

/** 测试服(内网) */
#define     kTestHostDomain        @"192.168.1.115"

/** 备用服(外网) */


/** 请求主机地址切换
 *   主正式服: kFormalRequestHost   测试服: kTestRequestHost    备用服: KStandbyRequestHost
 */
static NSString * _hostDomain = kTestHostDomain;

@interface NetworkRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager* sessionManager;

@property (nonatomic, copy) NSString *hostDomain;

@end

@implementation NetworkRequestManager

/*************************************** 完整单例语法 ***************************************/

static NetworkRequestManager * _instance = nil;

+ (instancetype)shareNetworkRequestManager {
    return [[self alloc] init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [super allocWithZone:zone];
            
//            NetworkRequestManagerServerTypeFormal ,     // 0：主正式服 (线上)
//
//            NetworkRequestManagerServerTypeTest,        // 1：测试服（内网/线下）
            
            [_instance changeRequestServerType:NetworkRequestManagerServerTypeTest]; // 默认服务器
        }
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

/*************************************** 完整单例语法 ***************************************/


/** 切换服务器 (更换请求主域名)  */
- (void)changeRequestServerType:(NetworkRequestManagerServerType)requestHostType {
    _requestHostType = requestHostType;
    
    switch (requestHostType) {
            case NetworkRequestManagerServerTypeFormal: {
                _hostDomain = kFormalHostDomain;      // 主正式服(线上)
                break;
            }
            case NetworkRequestManagerServerTypeTest: {    // 测试服(内网)
                _hostDomain = kTestHostDomain;
                break;
            }
        default:
            break;
    }
}

- (void)GET:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    [self request:HTTPRequestMethodGET URIPath:URIPath params:params success:success failure:failure];
}

- (void)POST:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    [self request:HTTPRequestMethodPOST URIPath:URIPath params:params success:success failure:failure];
}

- (void)request:(HTTPRequestMethod)method URIPath:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    
    NSString *token = [UserData token];
    if (token.length) [self.sessionManager.requestSerializer.HTTPRequestHeaders setValue:token forKey:kTokenKey];
    if (token.length == 0) DLog(@"token空了");
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", _hostDomain, URIPath];
    switch (method) {
            case HTTPRequestMethodPOST: {
                [self.sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    // ..
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    DLog(@"POST请求成功 responseObject == %@", responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"POST请求失败，网络错误！ error.localizedDescription == %@", error.localizedDescription);
                    
                }];
                break;
            }
            case HTTPRequestMethodGET: {
                [self.sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    // ..
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    DLog(@"GET请求成功 responseObject == %@", responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"GET请求失败，网络错误！ error.localizedDescription == %@", error.localizedDescription);
                    
                }];
                break;
            }
            // code..
        default:
            break;
    }
}

/** AFNetworking请求配置 */
- (AFHTTPSessionManager *)sessionManager{
    if (! _sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        // 设置 json 响应解析器 ,这样返回的数据就是解析好的 json 数据 ,不需要自己再做 json 解析
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:(NSJSONReadingAllowFragments)];
        
        // 设置支持的响应数据格式
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
        
        // 设置请求超时时长
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManager.requestSerializer.timeoutInterval = 15.0f;
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        // AFNetWorking 自动处理返回 null 对象的异常
        AFJSONResponseSerializer *jsonResponse = (AFJSONResponseSerializer *)_sessionManager.responseSerializer;
        jsonResponse.removesKeysWithNullValues = YES;
    }
    return _sessionManager;
}


/** AFNetworking请求配置 */
//- (void)configAFNetworkingRequest {
//
//}

@end
