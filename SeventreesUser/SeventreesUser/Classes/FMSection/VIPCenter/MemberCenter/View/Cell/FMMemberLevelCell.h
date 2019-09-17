//
//  FMMemberLevelCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"

@class FMMemberLevelModel;

#define     FMMemberLevelCellRowHeight      110.f

@interface FMMemberLevelCell : FMTableViewCell

@property (nonatomic, strong) FMMemberLevelModel *model;

@property (nonatomic, copy) NSString *subTitle;

@end
