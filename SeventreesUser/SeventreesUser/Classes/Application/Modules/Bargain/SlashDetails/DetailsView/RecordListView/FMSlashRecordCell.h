//
//  FMSlashRecordCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMBargainUserModel.h"

#define      FMSlashRecordCellHeight     70.f

@interface FMSlashRecordCell : FMTableViewCell

@property (nonatomic, strong) FMBargainUserModel *joinUserEntity;

@end
