//
//  FMNavSearchBarView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/22.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMNavSearchBarView : FMView

@property (nonatomic, strong) RACSubject *textChangeSubject;

@property (nonatomic, copy) void (^prevPageCallback)(void);

@end

NS_ASSUME_NONNULL_END
