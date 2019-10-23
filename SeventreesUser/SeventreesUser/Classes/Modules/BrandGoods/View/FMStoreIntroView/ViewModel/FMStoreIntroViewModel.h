//
//  FMStoreIntroViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMBrandModel.h"

@interface FMStoreIntroViewModel : FMViewModel

@property (nonatomic, strong) FMBrandInfoModel *brandInfoEntity;

@property (nonatomic, strong) RACSubject *addShopCarSubject;

@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
