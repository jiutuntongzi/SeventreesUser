//
//  FMBargainGoodsListController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewController.h"

@interface FMBargainGoodsListController : FMViewController

/** 请求参数：菜单分类ID */
@property (nonatomic, strong) NSNumber *categoryId;

/** 请求参数：砍价活动类型 */
@property (nonatomic, copy) NSString *activityType;

@end

