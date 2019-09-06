//
//  FMSpellGoodsInfoView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMSpellGoodsInfoView.h"

const CGFloat FMSpellGoodsInfoViewHeight = 150.f;

@interface FMSpellGoodsInfoView ()
/** 物流标签 */
@property (weak, nonatomic) IBOutlet UILabel *logisLabel;

@end

@implementation FMSpellGoodsInfoView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)setViewModel:(FMSpellGoodsInfoViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}

- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
    _viewModel = (FMSpellGoodsInfoViewModel *)_viewModel;
    
    return [super initWithViewModel:viewModel];
}

- (void)fm_setupSubviews {
    /// 物流标签富文本颜色
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"该商品支持快递配送、门店自提" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.f], NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:247/255.0 green:111/255.0 blue:111/255.0 alpha:1.0]} range:NSMakeRange(5, string.length)];
    _logisLabel.attributedText = string;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {

}

#pragma mark - System Functions

- (void)updateConstraints {
    
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMSpellGoodsInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMSpellGoodsInfoViewModel alloc] init];
    }
    return _viewModel;
}


@end
