//
//  FMStoreIntroViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@class FMBrandGoodsModel;

@interface FMStoreIntroViewModel : FMViewModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSNumber *number;

@property (nonatomic, strong) RACSubject *actionSubject;

@end
