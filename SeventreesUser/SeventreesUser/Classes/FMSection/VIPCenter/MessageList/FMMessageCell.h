//
//  FMMessageCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMMessageModel.h"

@interface FMMessageCell : FMTableViewCell

@property (nonatomic, strong) FMMessageModel *model;

@end
