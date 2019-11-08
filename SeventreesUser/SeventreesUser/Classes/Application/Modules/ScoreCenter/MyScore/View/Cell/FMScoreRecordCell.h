//
//  FMScoreRecordCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"

@class FMScoreRecordModel;

#define     FMScoreRecordCellRowHeight      75.f

@interface FMScoreRecordCell : FMTableViewCell

@property (nonatomic, strong) FMScoreRecordModel *scoreEntity;

@property (nonatomic, copy) NSString *subTitle;

@end
