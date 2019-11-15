//
//  FMPayViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/24.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"
#import "FMPayModel.h"

typedef NS_ENUM(NSUInteger, FMPayViewModelPaymentType) {
    FMPayViewModelPaymentTypeAli,
    FMPayViewModelPaymentTypeWechat
};

@interface FMPayViewModel : FMViewModel

@property (nonatomic, strong) NSNumber *orderId;

@property (nonatomic, assign) FMPayViewModelPaymentType paymentType;

@property (nonatomic, strong) FMPayModel *paymentEntity;


@property (nonatomic, strong) RACSubject *choicePaymentSubject;

@property (nonatomic, strong) RACSubject *refreshUISubject;

@property (nonatomic, strong) RACSubject *showHintSubject;

@property (nonatomic, strong) RACCommand *requestDataCommand;

@property (nonatomic, strong) RACCommand *requestPaymentCommand;



@end
