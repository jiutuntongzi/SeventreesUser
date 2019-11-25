//
//  FMSlashScopeView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#define         FMSlashScopeViewHeight        134.f

@interface FMSlashScopeView : FMView

@property (nonatomic, assign) CGFloat curPrice;

@property (nonatomic, assign) CGFloat lastPrice;

@property (nonatomic, copy) void(^inviteFriendsCallback)(void);

@end
