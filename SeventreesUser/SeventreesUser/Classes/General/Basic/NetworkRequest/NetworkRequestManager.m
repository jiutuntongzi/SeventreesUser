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

#define    kTimeoutInterval      15.0f
typedef NS_ENUM(NSUInteger, HTTPRequestMethod){
    HTTPRequestMethodPOST = 0,
    HTTPRequestMethodGET,
    HTTPRequestMethodPUT,
    HTTPRequestMethodDELETE,
};

/** 主正式服 */
#define     kFormalHostDomain      @""

/** 测试服(内网) */
#define     kTestHostDomain        @"http://192.168.1.135:8080"

/** 备用服(外网) */


/** 请求主机地址切换
 *   主正式服: kFormalRequestHost   测试服: kTestRequestHost    备用服: KStandbyRequestHost
 */
static NSString * _hostDomain = kTestHostDomain;

@interface NetworkRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) AFURLSessionManager *netSessionManager;

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
        if (! _instance) _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self configAFNetworking]; // 配置网络请求
        //            NetworkRequestManagerServerTypeFormal ,     // 0：主正式服 (线上)
        //            NetworkRequestManagerServerTypeTest,        // 1：测试服（内网/线下）
        [self changeRequestServerType:NetworkRequestManagerServerTypeTest]; // 默认服务器
    }
    return self;
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

/** AFNetworking配置: 自带处理NSNull对象 */
- (void)configAFNetworking {
    AFJSONResponseSerializer *jsonResponse = (AFJSONResponseSerializer *)_sessionManager.responseSerializer;
    jsonResponse.removesKeysWithNullValues = YES;
}

#pragma mark ——— AFURLSessionManager

- (void)GET:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    [self request:HTTPRequestMethodGET URIPath:URIPath params:params success:success failure:failure];
}

- (void)POST:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    [self request:HTTPRequestMethodPOST URIPath:URIPath params:params success:success failure:failure];
}

- (void)cancelRequests {
    if ([_netSessionManager.tasks count] > 0) {
        [_netSessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
        DLog(@"取消网络请求 URLSessionManager.tasks = %@", _netSessionManager.tasks);
    }
}

- (NSString *)requestMethod:(HTTPRequestMethod)method {
    NSString *requestMethod = @"POST";
    switch (method) {
        case HTTPRequestMethodGET: {
            requestMethod = @"GET";
            break;
        }
        case HTTPRequestMethodPOST: {
            requestMethod = @"POST";
            break;
        }
        // code..
        default:
            break;
    }
    return requestMethod;
}

- (void)request:(HTTPRequestMethod)method URIPath:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", _hostDomain, URIPath];
    NSString *requestMethod = [self requestMethod:method];
    DLog(@"\n%@请求URL:%@\n", requestMethod, urlString);
    
    NSDictionary *parameters = nil;
    if (method == HTTPRequestMethodGET) parameters = [params copy];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:requestMethod URLString:urlString parameters:parameters error:nil];
    request.timeoutInterval = 15;
    
    if (method != HTTPRequestMethodGET) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[params copy] ?: @{} options:0 error:&error];
        NSString *bodyJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSData *bodyData = [bodyJSON dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
        DLog(@"\n %@请求体参数: HTTPBodyJSON == %@ \n", requestMethod, bodyJSON);
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    if ([UserData token]) [request setValue:[UserData token] forHTTPHeaderField:@"token"];

    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    _netSessionManager = sessionManager;
    [[sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            DLog(@"\n %@请求失败！error == %@ \n", requestMethod, error.localizedDescription);
            failure(error);
            return;
        }
        NetworkResultModel *resultModel = [NetworkDataConver resultModelFromAFNetworkingResponseObject:responseObject];
        DLog(@"\n %@请求成功 response == %@ \n\n responseObject == %@ \n", requestMethod, response, responseObject);
        DLog(@"\n HTTP %@请求成功 JSONString == %@\n\n", requestMethod, resultModel.jsonString);
        success(resultModel);
        
    }] resume];
}

#pragma mark ——— AFHTTPSessionManager

- (void)GET:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    [self request:HTTPRequestMethodGET URIPath:URIPath parameters:params success:success failure:failure];
}

- (void)POST:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    [self request:HTTPRequestMethodPOST URIPath:URIPath parameters:params success:success failure:failure];
}

- (void)cancelRequestTasks {
    if ([self.sessionManager.tasks count] > 0) {
        [self.sessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
        DLog(@"网络请求被取消 HTTPSessionManager.tasks = %@", self.sessionManager.tasks);
    }
}

- (void)request:(HTTPRequestMethod)method URIPath:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {

    NSString *urlString = [NSString stringWithFormat:@"%@%@", _hostDomain, URIPath];
    DLog(@"\n HTTP请求URL:URLString == %@\n", urlString);
    switch (method) {
            case HTTPRequestMethodPOST: {
                [self.sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    // ..
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NetworkResultModel *resultModel = [NetworkDataConver resultModelFromAFNetworkingResponseObject:responseObject];
                    DLog(@"\n POST请求成功 responseObject == %@\n", responseObject);
                    DLog(@"\n POST请求成功 JSONString == %@\n\n", resultModel.jsonString);
                    success(resultModel);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"\n POST请求失败，网络错误！ task == %@ error.localizedDescription == %@\n", task, error.localizedDescription);
                    failure(error);
                }];
                break;
            }
            case HTTPRequestMethodGET: {
                [self.sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    // ..
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NetworkResultModel *resultModel = [NetworkDataConver resultModelFromAFNetworkingResponseObject:responseObject];
                    DLog(@"\n GET请求成功 responseObject == %@\n", responseObject);
                    DLog(@"\n GET请求成功 JSONString == %@\n\n", resultModel.jsonString);
                    success(resultModel);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    DLog(@"\n GET请求失败，网络错误！ task == %@ error.localizedDescription == %@ \n", task, error.localizedDescription);
                    failure(error);
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

        if ([UserData token]) {
            [self.sessionManager.requestSerializer.HTTPRequestHeaders setValue:[UserData token] forKey:kTokenKey];
        }
        
        // 请求体JSON类型问题 改使用原生HTTP请求 "Content type 'application/x-www-form-urlencoded;charset=UTF-8' not supported";
//        [_sessionManager.requestSerializer.HTTPRequestHeaders setValue:@"application/json" forKey:@"Content-Type"];
//        [_sessionManager.requestSerializer.HTTPRequestHeaders setValue:@"application/json" forKey:@"Accept"];
        
        // 设置 json 响应解析器 ,这样返回的数据就是解析好的 json 数据 ,不需要自己再做 json 解析
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:(NSJSONReadingAllowFragments)];
        
        // 设置支持的响应数据格式
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        
        /// 设置请求超时时长
        [_sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _sessionManager.requestSerializer.timeoutInterval = kTimeoutInterval;
        [_sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [self configAFNetworking]; // AFNetworking配置: 自带处理NSNull对象
    }
    return _sessionManager;
}

@end
