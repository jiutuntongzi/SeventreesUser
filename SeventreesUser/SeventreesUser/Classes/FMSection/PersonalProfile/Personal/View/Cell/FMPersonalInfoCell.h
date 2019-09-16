//
//  FMPersonalInfoCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"

@class FMPersonalInfoModel;

@interface FMPersonalInfoCell : FMTableViewCell

@property (nonatomic, strong) FMPersonalInfoModel *itemModel;

@property (nonatomic, copy) NSString *subTitle;

@end
