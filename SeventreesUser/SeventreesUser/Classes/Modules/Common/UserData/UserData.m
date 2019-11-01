//
//  UserData.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "UserData.h"

@implementation UserData

+ (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kTokenKey];
}

+ (void)saveToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kTokenKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeToken {
    [self saveToken:nil];
}

/*************************************** 完整单例语法 ***************************************/

static UserData * _instance = nil;

+ (instancetype)shareInstance {
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

/*************************************** 完整单例语法 ***************************************/

UserData * userData(void) {
    return [UserData shareInstance];
}

@end
