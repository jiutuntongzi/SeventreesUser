//
//  FMPasswordInputView.h
//  SeventreesUser
//
//  Created by wushiye on 2019/8/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMView.h"
#import "FMPasswordInputViewModel.h"

@interface FMPasswordInputView : FMView

@property (nonatomic, strong) FMPasswordInputViewModel *viewModel;

- (void)becomeFirstResponder;

@end
