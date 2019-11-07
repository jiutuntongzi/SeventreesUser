//
//  FMScoreHeaderView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/16.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMScoreHeaderView.h"

@interface FMScoreHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *explainButton;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation FMScoreHeaderView

- (void)fm_setupSubviews {
    _explainButton.layer.cornerRadius = 9.f;
    _explainButton.layer.borderColor = UIColor.whiteColor.CGColor;
    _explainButton.layer.borderWidth = 1.f;
    _explainButton.clipsToBounds = YES;
    
    _signInButton.layer.cornerRadius = 15.f;
}

@end
