//
//  FMPhoneNumberInputView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMPhoneNumberInputViewModel.h"

@interface FMPhoneNumberInputView : FMView

@property (nonatomic, strong) FMPhoneNumberInputViewModel *viewModel;

- (void)becomeFirstResponder;

@end

