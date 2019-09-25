//
//  FMMarkTitleView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/25.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMMarkTitleView.h"

@interface FMMarkTitleView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation FMMarkTitleView

- (void)setTitle:(NSString *)title {
    _title = title;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

@end
