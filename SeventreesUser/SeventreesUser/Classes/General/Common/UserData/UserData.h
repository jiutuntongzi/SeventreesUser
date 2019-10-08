//
//  UserData.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/8.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

#define  kTokenKey    @"token"

+ (NSString *)token;

+ (void)saveToken:(NSString *)token;

@end
