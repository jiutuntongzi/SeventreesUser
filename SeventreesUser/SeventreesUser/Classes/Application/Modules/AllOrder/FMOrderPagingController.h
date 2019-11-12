//
//  FMOrderPagingController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "WMPageController.h"
#include "FMOrderPagingType.h"

@interface FMOrderPagingController : WMPageController

+ (void)showByType:(unsigned int)type fromController:(UIViewController *)fromVC;

@end
