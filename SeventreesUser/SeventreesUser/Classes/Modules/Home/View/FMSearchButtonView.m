//
//  FMSearchButtonView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSearchButtonView.h"

@interface FMSearchButtonView ()

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation FMSearchButtonView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_searchButton addTarget:self action:@selector(searchButtonOnTouch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)searchButtonOnTouch:(UIButton *)button {
    if (_actionCallback) _actionCallback();
}

@end
