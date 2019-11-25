//
//  FMSlashDetailsController.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/7.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMViewController.h"

typedef NS_ENUM(NSUInteger, FMSlashDetailsControllerStyle) {
    FMSlashDetailsControllerStyleSlashing,           // 砍价中
    FMSlashDetailsControllerStyleSlashSuccess,       // 砍价成功
    FMSlashDetailsControllerStyleSlashFailure,       // 砍价失败
};

@interface FMSlashDetailsController : FMViewController

+ (void)showByPageType:(FMSlashDetailsControllerStyle)style activityId:(NSNumber *)activityId goodsId:(NSNumber *)goodsId;

@end
