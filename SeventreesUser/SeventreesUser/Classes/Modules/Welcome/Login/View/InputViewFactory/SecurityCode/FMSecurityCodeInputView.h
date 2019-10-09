//
//  FMSecurityCodeInputView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMSecurityCodeInputViewModel.h"

@interface FMSecurityCodeInputView : FMView

@property (nonatomic, strong) FMSecurityCodeInputViewModel *viewModel;

- (void)becomeFirstResponder;

@end

