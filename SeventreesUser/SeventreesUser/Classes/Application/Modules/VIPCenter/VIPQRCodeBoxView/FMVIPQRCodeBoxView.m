//
//  FMVIPQRCodeBoxView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMVIPQRCodeBoxView.h"

@interface FMVIPQRCodeBoxView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) id info;


@end

@implementation FMVIPQRCodeBoxView

#pragma mark ——— Set

- (void)setInfo:(id)info {
    _info = info;
    
    // code..
}

#pragma mark ——— Show

+ (void)showByInfo:(id)info {
    CGRect frame = [UIScreen mainScreen].bounds;
    FMVIPQRCodeBoxView *dialogView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    dialogView.frame = frame;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window endEditing:YES];
    [window addSubview:dialogView];
    
    dialogView.info = info;
}

#pragma mark ——— Action

- (IBAction)dismissButtonOnTouch {
    [self dismiss];
}

- (void)dismiss {
    [self endEditing];
    [self removeFromSuperview]; 
}

- (void)endEditing {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
