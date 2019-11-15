//
//  FMOrderListController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewController.h"
#include "FMOrderPagingType.h"

@interface FMOrderListController : FMViewController

/** 重新加载表格：刷新页面数据 */
- (void)requestReloadData;

@end
