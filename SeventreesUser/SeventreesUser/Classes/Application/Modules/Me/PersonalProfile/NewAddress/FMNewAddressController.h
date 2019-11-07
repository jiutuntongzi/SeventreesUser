//
//  FMNewAddressController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewController.h"

typedef NS_ENUM(NSUInteger, FMNewAddressControllerPageStyle) {
    FMNewAddressControllerPageStyleNew       = 0,         // 新建收货地址
    FMNewAddressControllerPageStyleEdit      = 1,         // 编辑收货地址
};

@interface FMNewAddressController : FMViewController

@property (nonatomic, assign) FMNewAddressControllerPageStyle stype;


@end
