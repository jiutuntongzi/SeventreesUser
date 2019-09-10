//
//  FMInputViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"


@interface FMInputViewModel : FMViewModel

@property (nonatomic, copy) NSString *hintText;

@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, strong) RACSubject *nextPageSubject;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@end
