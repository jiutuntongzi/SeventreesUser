//
//  FMInputViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMInputModel.h"

typedef NS_ENUM(NSUInteger, FMInputViewType) {
    FMInputViewTypeModifyPhone = 0,      //  修改手机号
    FMInputViewTypeModifyPassword,       //  修改登录密码
    FMInputViewTypeBindPhone,            //  绑定新手机号
    FMInputViewTypeBindStore,            //  换绑门店
};

@interface FMInputViewModel : FMViewModel

@property (nonatomic, strong) FMInputModel *inputModel;


@property (nonatomic, assign) FMInputViewType type;

@property (nonatomic, copy) NSString *hintText;

@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, strong) RACSubject *nextPageSubject;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACCommand *requestUpdateDataCommand;

@property (nonatomic, strong) RACSubject *showHintSubject;

@end
