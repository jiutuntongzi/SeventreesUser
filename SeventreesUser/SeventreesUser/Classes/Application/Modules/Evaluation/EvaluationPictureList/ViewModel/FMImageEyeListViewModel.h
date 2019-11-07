//
//  FMImageEyeListViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/10/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMImageEyeModel.h"

@interface FMImageEyeListViewModel : FMViewModel

@property (nonatomic, copy) NSArray<FMImageEyeModel *> *pictureModels;

@property (nonatomic, strong) RACSubject *selectItemSubject;

@end
