//
//  FMModel+RuntimeCopy.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <objc/runtime.h>

#import "FMModel+RuntimeCopy.h"

@implementation FMModel (RuntimeCopy)

+ (void)load {
    [self fm_addProtocolByName:@"NSCopying"];
    [self fm_addProtocolByName:@"NSMutableCopying"];
}
    
- (nonnull id)copyWithZone:(NSZone *)zone {
    return [self fm_copyModelWithZone:zone];
}
    
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [self fm_copyModelWithZone:zone];
}
    
    
#pragma mark - Public Function
    
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}
    
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
    
#pragma mark - Private Function
    
+ (void)fm_addProtocolByName:(NSString *)protocolName {
    Class class = [self class];
    const char *copyingProtocolName = [@"NSCopying" UTF8String];
    Protocol *copyingProtocol = objc_getProtocol(copyingProtocolName);
    if (!class_conformsToProtocol(class, copyingProtocol)) {
        class_addProtocol(class, copyingProtocol);
    }
}
    
- (nonnull id)fm_copyModelWithZone:(nullable NSZone *)zone {
    Class class = [self class];
    id copyModel = [[class allocWithZone:zone] init];
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(class, &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *ivarNameKey = [NSString stringWithUTF8String:ivarName];
        id value = [self valueForKey:ivarNameKey];
        [copyModel setValue:value forKey:ivarNameKey];
    }
    free(ivars);
    return copyModel;
}
    
@end
