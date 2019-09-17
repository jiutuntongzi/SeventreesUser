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

@end


