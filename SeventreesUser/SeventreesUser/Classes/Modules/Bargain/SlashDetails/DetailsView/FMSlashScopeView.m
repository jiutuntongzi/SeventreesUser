//
//  FMSlashScopeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashScopeView.h"

@interface FMSlashScopeView ()

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation FMSlashScopeView

- (void)fm_setupSubviews {
    _leftButton.layer.cornerRadius = 5.f;
    _leftButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _leftButton.layer.borderWidth = 1.f;
    
    _rightButton.layer.cornerRadius = 5.f;
}

- (void)fm_bindViewModel {
    
}

@end
