//
//  FMStoreCheckCell.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTableViewCell.h"
#import "FMStoreCheckViewModel.h"

@interface FMStoreCheckCell : FMTableViewCell

@property (nonatomic, strong) FMStoreCheckViewModel *viewModel;

- (void)selectCurrentCell;

@end
