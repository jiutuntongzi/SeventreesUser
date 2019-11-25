//
//  FMBargainUserModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/11/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMModel.h"

@interface FMBargainUserModel : FMModel

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) CGFloat price;

@end

/*
{
    "headUrl": "https://bbs-fd.zol-img.com.cn/t_s1200x5000/g4/M01/00/03/Cg-4WVQHEoCIaGc-AAN1EbYuLlsAARH5gGsRuoAA3Up966.jpg",
    "userName": "隔壁老六",
    "time": "2019-10-11 17:31:29",
    "price": 27.78
}
*/
