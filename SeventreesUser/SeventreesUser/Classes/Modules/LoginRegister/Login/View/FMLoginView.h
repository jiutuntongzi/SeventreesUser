//
//  FMLoginView.h
//  RAC-Demo
//
//  Created by WsyMac on 2019/1/16.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "FMView.h"
#import "FMLoginViewModel.h"

typedef NS_ENUM(NSUInteger, FMLoginViewStyle) {
    FMLoginViewStylePhoneNumber,    // 手机号
    FMLoginViewStylePassword       // 密码
};

@interface FMLoginView : FMView

@property (nonatomic, assign) FMLoginViewStyle style;

@property (nonatomic, strong) FMLoginViewModel *viewModel;

@end

