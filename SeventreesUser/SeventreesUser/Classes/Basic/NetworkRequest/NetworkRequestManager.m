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
#define     kTestHostDomain        @"http://192.168.1.131:8080"

@interface NetworkRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) AFURLSessionManager *netSessionManager;

/** 请求主机地址切换
 *   主正式服: kFormalRequestHost   测试服: kTestRequestHost    备用服: KStandbyRequestHost
 */
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

- (BOOL)checkHasEmptyForRequestParams:(NSDictionary *)params failure:(NetworkRequestFailure)failure {
    __block BOOL hasNil = NO;
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        if (!value) {
            DLog(@"\n请求参数错误：有参数值nil了！RequestParams -> key：%@, value：%@\n", key, value);
            hasNil = YES;
        }
    }];
    if (hasNil) {
        NSString *errorDescr = [NSString stringWithFormat:@"请求参数错误：有参数(nil)了！params:%@", params];
        NSError *error = [NSError errorCode:NSCommonErrorCodeFailed userInfo:@{NSLocalizedDescriptionKey:errorDescr, NSLocalizedFailureReasonErrorKey:@"有参数值nil了！", NSLocalizedRecoverySuggestionErrorKey:@"请求参数错误"}];
        if (failure) failure(error);
    }
    return hasNil;
}

#pragma mark ——— AFURLSessionManager

- (void)GET:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    if ([self checkHasEmptyForRequestParams:params failure:failure]) return;
    [self request:HTTPRequestMethodGET URIPath:URIPath params:params success:success failure:failure];
}

- (void)POST:(NSString *)URIPath params:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    if ([self checkHasEmptyForRequestParams:params failure:failure]) return;
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
    DLog(@"\n %@请求 URL:%@\n", requestMethod, urlString);
    
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
        DLog(@"\n AFURLSessionManager %@请求成功 response == %@ \n\n responseObject == %@ \n", requestMethod, response, responseObject);
        NSString *resultJSONString = resultModel.jsonString;
        DLog(@"\n AFURLSessionManager HTTP %@请求成功 JSONString == %@\n\n", requestMethod, resultJSONString);
        success(resultModel);
        
    }] resume];
}

#pragma mark ——— AFHTTPSessionManager

- (void)GET:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    if ([self checkHasEmptyForRequestParams:params failure:failure]) return;
    [self request:HTTPRequestMethodGET URIPath:URIPath parameters:params success:success failure:failure];
}

- (void)POST:(NSString *)URIPath parameters:(NSDictionary *)params success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    if ([self checkHasEmptyForRequestParams:params failure:failure]) return;
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

#pragma mark ——— NSURLSession

- (void)POST:(NSString *)URLString success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    DLog(@"\n（NSURLSession）原生网络请求(POST表单上传方式):URLString == %@\n", URLString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"]; // 表单提交
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                DLog(@"\n（NSURLSession）原生网络请求失败！（POST表单上传方式）error.localizedDescription == %@ \n", error.localizedDescription);
                failure(error);
                return;
            }
            NetworkResultModel *resultModel = nil;
            if (data) {
                NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
                resultModel = [NetworkDataConver resultModelFromAFNetworkingResponseObject:resultDict];
            }
            DLog(@"\n（NSURLSession）原生网络请求成功（POST表单上传方式）response == %@ \n\n resultModel == %@ \n\n", response, resultModel);
            DLog(@"\n JSONString == %@\n\n", resultModel.jsonString);
            success(resultModel);
        });
    }] resume];
}

#pragma mark ——— Network API

- (void)requestLoginWithPhoneNumber:(NSString *)phoneNumber verifyCode:(NSString *)verifyCode password:(NSString *)password success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    // 运营品牌 1：Seventrees
    NSString *username = [NSString stringWithFormat:@"%@,%d", phoneNumber, 1];
    NSString *loginURIPath;
    if (verifyCode.length) {
        loginURIPath = [NSString stringWithFormat:@"%@?username=%@&password=%@", kLoginURIPath, username, verifyCode];
    } else if (password.length) {
        loginURIPath = [NSString stringWithFormat:@"%@?username=%@&password=%@", kLoginURIPath, username, password];
    } else {
        DLog(@"（NSURLSession）请求登录：拼接URLPath参数失败!");
        NSError *error = [NSError errorCode:NSCommonErrorCodeFailed userInfo:@{NSLocalizedDescriptionKey:@"登录失败：请求参数错误！", NSLocalizedFailureReasonErrorKey:@"请求登录：拼接URLPath参数失败!", NSLocalizedRecoverySuggestionErrorKey:@"请求路径参数错误"}];
        if (failure) failure(error);
    }
    NSString *URLString = [_hostDomain stringByAppendingString:loginURIPath];
    [self POST:URLString success:success failure:failure];
}

- (void)requestHomeListDataWithLongitude:(NSString *)longitude latitude:(NSString *)latitude success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    params[@"latitude"] = latitude; // 纬度
    params[@"longitude"] = longitude; // 经度
    
    [self POST:kHomeListURIPath params:params success:^(NetworkResultModel *resultModel) {
        success(resultModel);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestFindGoodsOrBrandWithName:(NSString *)name success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
    params[@"name"] = name;
    
    [self POST:kHomeFindNameLikeURIPath params:params success:^(NetworkResultModel *resultModel) {
        success(resultModel);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestSearchGoodsName:(NSString *)goodsName categoryId:(NSInteger)categoryId activityType:(NSInteger)activityType sortMethod:(NSInteger)sortMethod sortSequence:(NSInteger)sortSequence pageNo:(NSInteger)pageNo limit:(NSInteger)limit success:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:1];
    params[@"goodsName"] = goodsName;
    params[@"categoryId"] = @(categoryId);
    params[@"activityType"] = @(activityType);
    params[@"sidx"] = @(sortMethod);
    params[@"order"] = @(sortSequence);
    params[@"page"] = @(pageNo);
    params[@"limit"] = @(limit);
    
    [self POST:kHomeFindNameLikeURIPath params:params success:^(NetworkResultModel *resultModel) {
        success(resultModel);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
