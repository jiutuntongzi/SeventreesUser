//
//  FMTitleView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMTitleView.h"

@interface FMTitleView ()

@property (nonatomic, weak) IBOutlet UILabel *leftLabel;

@property (nonatomic, weak) IBOutlet UILabel *rightLabel;

@end

@implementation FMTitleView

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

@end
