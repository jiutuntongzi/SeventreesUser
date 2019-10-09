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

@end
