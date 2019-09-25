//
//  FMCiphertextInputViewModel.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMCiphertextInputViewModel : FMViewModel

/** 输入密码文本做变化 */
@property (nonatomic, strong) RACSubject *textChangedSubject;

/** 输入的密码 */
@property (nonatomic, copy) NSString *passwordNumber;

/** 显/隐藏明文图标（默认）：NO */
@property (nonatomic, assign) BOOL isShowPlaintext;

/** 暗文图标：YES / 明文图标（默认）：NO */
@property (nonatomic, assign) BOOL isPlaintext;

/** 明/暗文图标点击信号 */
@property (nonatomic, strong) RACSubject *plaintextTouchSubject;

@end

NS_ASSUME_NONNULL_END
