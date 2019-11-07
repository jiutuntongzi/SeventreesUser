//
//  FMLoginController.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMViewController.h"

@interface FMLoginController : FMViewController

@property (nonatomic, copy) void(^loginSuccessBlock)(void);

@end
