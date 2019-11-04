//
//  FMAddressInfoCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMAddressInfoModel.h"

@interface FMAddressInfoCell : FMTableViewCell

@property (nonatomic, copy) void (^editActionBlock)(FMAddressInfoModel *addressModel);

@property (nonatomic, strong) FMAddressInfoModel *model;

@end
