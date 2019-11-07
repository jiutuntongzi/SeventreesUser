//
//  FMGoodsDetailsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/30.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsDetailsCell.h"
#import "ChainKit.h"

@interface FMGoodsDetailsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@end

@implementation FMGoodsDetailsCell

- (void)fm_setupSubviews {
    self.ctc_selectedColor(nil);
}

- (void)fm_bindViewModel {
    [RACObserve(self.viewModel, goodsModel) subscribeNext:^(FMGoodsDetailsModel *goodsModel) {
        
    }];
}

- (FMGoodsDetailsCellViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMGoodsDetailsCellViewModel alloc] init];
    }
    return _viewModel;
}

@end
