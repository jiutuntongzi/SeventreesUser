//
//  FMGoodsSKUModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/23.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMGoodsSKUModel : FMModel

@property (nonatomic, strong) NSNumber *skuId;

@property (nonatomic, copy) NSString *skuCode;

@property (nonatomic, strong) NSNumber *goodsId;

@property (nonatomic, strong) NSNumber *activityId;

/** --sku参数   如： "{\"颜色\":\"红色\",\"尺码\":\"大码\"}" */
@property (nonatomic, copy) NSString *propertiesName;

/** --市场价 */
@property (nonatomic, assign) CGFloat normalPrice;

/** --零售价 */
@property (nonatomic, assign) CGFloat retailPrice;

/** --活动价 */
@property (nonatomic, assign) CGFloat salePrice;

/** --虚拟销量 */
@property (nonatomic, strong) NSNumber *virtualSales;

/** --销量 */
@property (nonatomic, strong) NSNumber *sales;

/** --库存 */
@property (nonatomic, strong) NSNumber *stock;

/** --SKU商品图 */
@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, strong) NSNumber *createdId;

@property (nonatomic, copy) NSString *createdDateTime;

@property (nonatomic, strong) NSNumber *lastModifiedId;

@property (nonatomic, copy) NSString *lastModifiedDateTime;

@property (nonatomic, copy) NSDictionary *extra;

@property (nonatomic, copy) NSString *dr;

@end

