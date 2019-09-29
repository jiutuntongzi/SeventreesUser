//
//  FMSlashGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/6.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSlashGoodsCell.h"

@interface FMSlashGoodsCell ()

@property (nonatomic, weak) IBOutlet UIButton *nextButton;

@end

@implementation FMSlashGoodsCell

- (void)fm_setupSubviews {
    
    _nextButton.layer.cornerRadius = 15.f;
    _nextButton.layer.borderColor = UIColor.cc_colorByHexString(@"#F76F6F").CGColor;
    _nextButton.layer.borderWidth = 1.f;
}

- (void)fm_bindViewModel {
    [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

- (FMSlashGoodsCellViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMSlashGoodsCellViewModel alloc] init];
    }
    return _viewModel;
}

@end
