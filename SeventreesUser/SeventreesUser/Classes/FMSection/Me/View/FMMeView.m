//
//  FMMeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMeView.h"

@interface FMMeView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopMarginCons;

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIView *totalContentView;



@end

@implementation FMMeView

/** 设置子views */
- (void)fm_setupSubviews {
    _headImgView.layer.cornerRadius = 30.f;
    _headImgView.layer.borderWidth = 2.f;
    _headImgView.layer.borderColor = UIColor.whiteColor.CGColor;
    [_headImgView setClipsToBounds:YES];
    
    _totalContentView.layer.shadowColor = [UIColor colorWithRed:13/255.0 green:6/255.0 blue:8/255.0 alpha:0.03].CGColor;
    _totalContentView.layer.shadowOffset = CGSizeMake(0,2);
    _totalContentView.layer.shadowOpacity = 1;
    _totalContentView.layer.shadowRadius = 4;
    _totalContentView.layer.cornerRadius = 5;
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    
};

@end
