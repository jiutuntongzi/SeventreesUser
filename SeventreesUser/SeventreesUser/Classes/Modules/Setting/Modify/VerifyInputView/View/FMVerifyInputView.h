//
//  FMVerifyInputView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"

#import "FMVerifyInputViewModel.h"

extern const CGFloat FMVerifyInputViewHeight;

@interface FMVerifyInputView : FMView

@property (nonatomic, strong) FMVerifyInputViewModel *viewModel;

- (void)fm_becomeFirstResponder;

@end
