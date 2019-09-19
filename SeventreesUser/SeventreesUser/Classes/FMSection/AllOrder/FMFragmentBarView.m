//
//  FMFragmentBarView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMFragmentBarView.h"

@interface FMFragmentBarView ()

@property (weak, nonatomic) IBOutlet UIButton *onLineOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *offlineButton;

@end

@implementation FMFragmentBarView

#define     kRedColor    [UIColor colorWithRed:247.f/255.f green:111.f/255.f blue:111.f/255.f alpha:1.0f]

- (void)setType:(UInt8)type {
    UIColor *selectedTitleColor = UIColor.whiteColor;
    UIColor *selectedBackColor = kRedColor;
    UIColor *normalTitleColor = kRedColor;
    UIColor *normalBackColor = UIColor.whiteColor;
    
    void (^setBackColorBlock)(UIButton *, UIColor *) = ^(UIButton *button, UIColor *color) {
        button.backgroundColor = color;
    };
    void (^setTitleColorBlock)(UIButton *, UIColor *) = ^(UIButton *button, UIColor *color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    };
    if (type == 1) {
        setTitleColorBlock(_onLineOrderButton, selectedTitleColor);
        setBackColorBlock(_onLineOrderButton, selectedBackColor);
        
        setTitleColorBlock(_offlineButton, normalTitleColor);
        setBackColorBlock(_offlineButton, normalBackColor);
    } else {
        setTitleColorBlock(_offlineButton, normalTitleColor);
        setBackColorBlock(_offlineButton, normalBackColor);
        
        setTitleColorBlock(_onLineOrderButton, selectedTitleColor);
        setBackColorBlock(_onLineOrderButton, selectedBackColor);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];

    void (^setStyleBlock)(UIView *, UIColor *) = ^(UIView *view, UIColor *color) {
        view.layer.borderColor = color.CGColor;
        view.layer.borderWidth = 1.f;
    };
    setStyleBlock(self, kRedColor);
    
    self.type = 0;
    
    [_onLineOrderButton addTarget:self action:@selector(typeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)typeButtonDidClick:(UIButton *)btn {
    self.type = btn.tag;
    
    if (_actionCallback) _actionCallback(_type);
}

@end
