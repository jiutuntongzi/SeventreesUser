//
//  FMNavSearchBarView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/22.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

@interface FMNavSearchBarView : FMView

@property (nonatomic, copy) void (^prevPageCallback)(void);

@property (nonatomic, copy) void (^searchTouchCallback)(NSString *searchText);

@end

