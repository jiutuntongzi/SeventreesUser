//
//  FMStoreIntroView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMStoreIntroView.h"

@interface FMStoreIntroView ()

@property (weak, nonatomic) IBOutlet UIImageView *storeImgView;

@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsTotalLabel;

@property (weak, nonatomic) IBOutlet UITextView *introTextView;

@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@property (weak, nonatomic) IBOutlet UIButton *moreDownButton;

@end

@implementation FMStoreIntroView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

- (void)fm_setupSubviews {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.f;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName:[UIFont systemFontOfSize:13.f],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]
                                 };
    _introTextView.attributedText = [[NSAttributedString alloc] initWithString:_introTextView.text attributes:attributes];
    
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self);
    
    [RACObserve(self.viewModel, brandInfoEntity) subscribeNext:^(FMBrandInfoModel *brandInfoEntity) {
        @strongify(self);
        [self->_storeImgView sd_setImageWithURL:[NSURL URLWithString:brandInfoEntity.logoUrl]];
        self->_storeNameLabel.text = brandInfoEntity.name ?: @"--";
        self->_goodsTotalLabel.text = [NSString stringWithFormat:@"共%@件商品", brandInfoEntity.goodsTotal];
        self->_introTextView.text = brandInfoEntity.details ?: @"暂无";
    }];
    
//    [[_collectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//
//    }];
}

#pragma mark - System Functions

//- (void)updateConstraints {
//
//    [super updateConstraints];
//}

#pragma mark - Lazyload

- (FMStoreIntroViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMStoreIntroViewModel alloc] init];
    }
    return _viewModel;
}

@end
