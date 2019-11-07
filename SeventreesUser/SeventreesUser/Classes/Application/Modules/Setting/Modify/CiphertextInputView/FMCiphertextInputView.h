//
//  CiphertextInputView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMCiphertextInputViewModel.h"

@interface FMCiphertextInputView : FMView

@property (nonatomic, strong) FMCiphertextInputViewModel *viewModel;

- (void)fm_becomeFirstResponder;

@end

