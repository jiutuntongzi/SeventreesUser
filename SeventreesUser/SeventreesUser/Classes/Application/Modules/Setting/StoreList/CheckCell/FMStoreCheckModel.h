//
//  FMStoreCheckModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/12.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMStoreCheckModel : FMModel

@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isCheck;


@property (nonatomic, strong) NSNumber *storeId;

@property (nonatomic, copy) NSString *dr;

@property (nonatomic, copy) NSDictionary *extra;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *detailedAddress;

@property (nonatomic, copy) NSString *logoUrl;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *storeDistance;

@end

/*
{
    "extra": {},
    "id": 17,    --门店id
    "dr": "N",
    "name": "孩子屋",    --门店名字
    "phone": "13515562548",    --门店电话
    "detailedAddress": "鼓楼大街21号",    --门店地址
    "logoUrl": "http://shengmei1868.com/erp/20190819/97372da9c3584cfb95dd23b16366be35.png",
    "latitude": "39.92855",    --门店纬度
    "longitude": "116.41637",    --门店经度
    "storeDistance": "4.910147348490498"    --距离
}

*/
