//
//  FMPhoneInputView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#import "FMPhoneInputViewModel.h"

extern const CGFloat FMPhoneInputViewHeight;

@interface FMPhoneInputView : FMView

@property (nonatomic, strong) FMPhoneInputViewModel *viewModel;

- (void)fm_becomeFirstResponder;

@end
