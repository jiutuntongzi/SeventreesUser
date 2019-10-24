//
//  FMCollectBrandCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMCollectBrandCell.h"

@interface FMCollectBrandCell ()

@property (weak, nonatomic) IBOutlet UIImageView *brandImgView;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;

@end

@implementation FMCollectBrandCell

- (void)fm_bindViewModel {
    @weakify(self)
    [RACObserve(self, brandModel) subscribeNext:^(FMCollectBrandModel *brandModel) {
        @strongify(self)
        [self->_brandImgView sd_setImageWithURL:[NSURL URLWithString:brandModel.logoUrl]];
        self->_brandNameLabel.text = brandModel.name;
        self->_goodsCountLabel.text = brandModel.num.stringValue;
    }];
}

- (void)fm_setupSubviews {
    self.ctc_selectedColor(nil); // 默认点暗色
    
    _brandImgView.layer.borderWidth = 1.f;
    _brandImgView.layer.borderColor = UIColor.cc_colorByHexString(@"#E5E5E5").CGColor;
}

@end
