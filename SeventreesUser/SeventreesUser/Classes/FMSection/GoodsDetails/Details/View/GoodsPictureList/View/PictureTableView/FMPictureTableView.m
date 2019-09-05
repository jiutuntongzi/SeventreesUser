//
//  FMPictureTableView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMPictureTableView.h"

@implementation FMPictureTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.scrollEnabled = NO;
        self.bounces = NO;
        self.estimatedRowHeight = 270.f;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}



@end
