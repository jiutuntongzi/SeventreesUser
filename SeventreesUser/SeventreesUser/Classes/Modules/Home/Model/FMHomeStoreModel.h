//
//  FMHomeStoreModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMHomeStoreModel : FMModel

/** logo图片 */
@property (nonatomic, copy) NSString *shopLogo;

/** 品牌名称 */
@property (nonatomic, copy) NSString *brandName;

/** 导购名称 */
@property (nonatomic, copy) NSString *guideName;

/** 门店名称 */
@property (nonatomic, copy) NSString *shopName;

/** 导购Id */
@property (nonatomic, strong) NSNumber *guideId;

/** 距离，-1代表未知距离 */
@property (nonatomic, strong) NSNumber *distance;

@end
