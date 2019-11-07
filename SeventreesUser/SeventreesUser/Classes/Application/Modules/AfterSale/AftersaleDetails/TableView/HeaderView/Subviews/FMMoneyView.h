//
//  FMMoneyView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

#define         FMMoneyView_height      44.f

@interface FMMoneyView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSNumber *money;

@end

