//
//  FMGoodsViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/9/5.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

@interface FMGoodsViewModel : FMViewModel

@property (nonatomic, strong) RACSubject *selectActionSubject;

@property (nonatomic, strong) RACSubject *addActionSubject;

@end
