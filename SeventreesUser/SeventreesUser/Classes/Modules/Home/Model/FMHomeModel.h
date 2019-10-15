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
#import "FMHomeGroupsModel.h"

#import "FMHomeStoreModel.h"

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


/** 轮播图项模型s */
@property (nonatomic, copy) NSArray<FMHomeCarouselModel *> *carouselModels;

/** 首页菜单 */
@property (nonatomic, copy) NSArray<FMHomeMenuModel *> *menuModels;

/** 推荐商品分组 */
@property (nonatomic, copy) NSArray<FMHomeGroupsModel *> *goodsGroupModels;


#pragma mark ——— 手动转换处理的数据
/** 处理的轮播图片s */
@property (nonatomic, copy) NSArray<NSString *> *pictureURLStrings;

/** 处理的店铺信息模型 */
@property (nonatomic, strong) FMHomeStoreModel *storeModel;



@end

/**
 {"message":"操作成功","response":{"groups":[{"picUrl":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/cdbc9de5cbd8400ea39285fbde356707.png","goods":[{"id":16,"normalPrice":213123,"url":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/b93bde98ae37421699eb80b73f7d9af0.png","activityType":"bargain","activityId":1,"retailPrice":100,"stock":100,"bargainDiscount":1,"num":200,"promotionDiscount":2,"name":"奶粉","promotionMax":8}]}],"menus":[{"name":"优惠卷","picUrl":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/4392edf951804816bb193755ddf3a528.png","code":"sr"},{"name":"多人拼团","picUrl":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/9cd8d0ddb86f4a6698463e4ef5e36ff4.png","code":"group"},{"name":"砍到爽","picUrl":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/2ba95593b6d04ba2a705244c5b531be6.png","code":"bargain"},{"name":"促销活动","picUrl":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/bc17c9af3c2c4c058e9e274885d926e5.png","code":"parcel"}],"distance":7169.5555999999997,"imgs":[{"jump":"http:\/\/www.baidu.com","jumpType":"2","activityType":"normal","picUrl":"http:\/\/qiniu.shengmei1858.com\/upload\/20190906\/4b16b0ae83f241c0a09b662076dee792.jpg"}],"shopName":"123","shopLogo":"http:\/\/qiniu.shengmei1858.com\/upload\/20190920\/b93bde98ae37421699eb80b73f7d9af0.png","brandName":"美贝美妈","guideName":"导购名"},"code":"OK"}
 */
