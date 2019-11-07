//
//  SearchBarView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBarView : UIView

@property (nonatomic, copy) NSString *searchText;

@property (nonatomic, copy) void (^searchTouchCallback)(NSString *searchText);

@end

