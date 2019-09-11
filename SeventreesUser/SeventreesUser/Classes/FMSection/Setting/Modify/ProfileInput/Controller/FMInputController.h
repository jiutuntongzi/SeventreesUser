//
//  FMInputController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMViewController.h"

typedef NS_ENUM(NSUInteger, FMInputControllerType) {
    FMInputControllerTypeModifyPhone = 0,        //  修改手机号
    FMInputControllerTypeModifyPassword,         //  修改登录密码
    FMInputControllerTypeBindPhone,              //  绑定新手机号
    FMInputControllerTypeBindStore,              //  换绑门店
};

@interface FMInputController : FMViewController

@property (nonatomic, assign) FMInputControllerType type;

@end
