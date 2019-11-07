//
//  FMGoodsEvaluationViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsEvaluationViewModel.h"

@implementation FMGoodsEvaluationViewModel

- (RACSubject *)selectItemSubject {
    if (! _selectItemSubject) {
        _selectItemSubject = [[RACSubject alloc] init];
    }
    return _selectItemSubject;
}

@end
