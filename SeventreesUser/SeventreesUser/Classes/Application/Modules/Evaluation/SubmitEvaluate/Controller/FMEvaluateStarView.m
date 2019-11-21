//
//  FMEvaluateStarView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/11/21.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMEvaluateStarView.h"

@interface FMEvaluateStarView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *starBtns;

@end

@implementation FMEvaluateStarView

- (IBAction)startOnTouch:(UIButton *)startButton {
    for (UIButton *startBtn in _starBtns) startBtn.selected = NO;
    
    for (UInt8 idx = 0; idx != startButton.tag; idx ++) {
        UIButton *startBtn = _starBtns[idx];
        startBtn.selected = YES;
    }
    _starValue = startButton.tag; // 星数
    
    [self setupStarNumber];
}

- (void)setStarValue:(UInt8)starValue {
    _starValue = starValue;
    
    if (starValue == 0 || starValue > 5) {
        if (starValue == 0) {
            for (UIButton *startBtn in _starBtns) startBtn.selected = NO;
        } else {
            if (starValue > 5) for (UIButton *startBtn in _starBtns) startBtn.selected = YES;
        }
        [self setupStarNumber];
        return;
    }
    UInt8 idx = starValue - 1;
    [self startOnTouch:_starBtns[idx]];
}

- (void)setupStarNumber {
    for (UIButton *startBtn in _starBtns) {
        NSString *imageName = startBtn.selected ? @"icon_evaluate_star_selected" : @"icon_evaluate_star_normal";
        startBtn.cb_imageOfNamed(imageName);
    }
}

@end
