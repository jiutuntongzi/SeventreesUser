//
//  DialogBoxView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DialogBoxViewStyle) {
    DialogBoxViewStyleAffirm,      // 取消 / 确定
    DialogBoxViewStyleHint,        // 知道了
    DialogBoxViewStyleInput         // 输入（TextField）
};

@interface DialogBoxView : UIView

+ (void)showByTitle:(NSString *)title message:(NSString *)message affirmButtonTitle:(NSString *)affirmTitle forStyle:(DialogBoxViewStyle)style affirmHandler:(void(^)(NSString * __nullable))affirmCallback;

//         [DialogBoxView showByTitle:@"发现新版本" message:@" 1. 日常系统优化\n\n 2. 新增会员心痛，提升用户优惠服务\n\n 3. 年中大庆开始啦！参与活动暑假嗨到底" affirmButtonTitle:@"确定" forStyle:DialogBoxViewStyleInput affirmHandler:^(NSString *inputText) {
//             DLog(@"点了确定OK inputText == %@", inputText);
//         }];

- (void)dismiss;

@end


