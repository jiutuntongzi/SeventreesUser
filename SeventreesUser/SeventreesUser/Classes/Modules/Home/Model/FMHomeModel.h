//
//  FMHomeModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

#import "FMHomeCarouselModel.h"
#import "FMHomeMenuModel.h"
#import "FMHomeGoodsModel.h"

@interface FMHomeModel : FMModel

/** 品牌名称 */
@property (nonatomic, copy) NSString *brandName;

/** 导购名称 */
@property (nonatomic, copy) NSString *guideName;

/** 门店名称 */
@property (nonatomic, copy) NSString *shopName;

/** logo图片 */
@property (nonatomic, copy) NSString *shopLogo;

/** 导购Id */
@property (nonatomic, strong) NSNumber *guideId;

/** 距离，-1代表未知距离 */
@property (nonatomic, strong) NSNumber *distance;



/** 轮播图 */
@property (nonatomic, copy) NSArray<FMHomeCarouselModel *> *imgs;

/** 首页菜单 */
@property (nonatomic, copy) NSArray<FMHomeMenuModel *> *menus;

/** 推荐商品组 */
@property (nonatomic, copy) NSDictionary *groups;

/** 商品列表 */
@property (nonatomic, copy) NSArray<FMHomeGoodsModel *> *goodsArray;

@end

