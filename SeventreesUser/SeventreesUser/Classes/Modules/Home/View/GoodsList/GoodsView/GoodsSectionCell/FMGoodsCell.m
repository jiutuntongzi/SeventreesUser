//
//  FMGoodsCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsCell.h"

#import "MacroHeader.h"

@interface FMGoodsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *shoppingCarButton;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end

@implementation FMGoodsCell

/** 设置子views */
- (void)fm_setupSubviews {
};

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    @weakify(self)
    
//    [[self.viewModel rac_valuesAndChangesForKeyPath:@"goodsModel" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self)
//        FMHomeGoodsModel *goodsModel = tuple.first;
//        [self->_goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgUrl]];
//        self->_goodsTitleLabel.text = goodsModel.name;
//        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@", goodsModel.retailPrice];
//    }];
    
    [RACObserve(self.viewModel, goodsModel) subscribeNext:^(FMHomeGoodsModel *goodsModel) {
        @strongify(self)    if (! self) return;

        [self->_goodsImgView sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgUrl]];
        self->_goodsTitleLabel.text = goodsModel.name;
        self->_goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@", goodsModel.retailPrice];
    }];
    
    [[_shoppingCarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [self.viewModel.addActionSubject sendNext:self.viewModel.goodsModel];
    }];
    
    [[_selectButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id button) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [self.viewModel.selectActionSubject sendNext:self.viewModel.goodsModel];
    }];
};

- (FMGoodsCellViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMGoodsCellViewModel alloc] init];
    }
    return _viewModel;
}

@end
