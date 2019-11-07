//
//  FMStoreIntroViewModel.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreIntroViewModel.h"

@implementation FMStoreIntroViewModel

- (RACSubject *)selectItemSubject {
    if (! _selectItemSubject) {
        _selectItemSubject = [[RACSubject alloc] init];
    }
    return _selectItemSubject;
}

- (RACSubject *)addShopCarSubject {
    if (! _addShopCarSubject) {
        _addShopCarSubject = [[RACSubject alloc] init];
    }
    return _addShopCarSubject;
}

@end
