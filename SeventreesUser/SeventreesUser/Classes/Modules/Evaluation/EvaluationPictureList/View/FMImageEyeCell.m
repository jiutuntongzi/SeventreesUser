//
//  FMImageEyeCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMImageEyeCell.h"

const CGFloat FMImageEyeCellSize = 80.f;

@interface FMImageEyeCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation FMImageEyeCell

/** 设置子views */
- (void)fm_setupSubviews {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:UIImage.ci_imageNamed(@"test80")];
    imgView.contentMode = UIViewContentModeScaleToFill;
    self.cv_addSubview(imgView);
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
};

- (void)updateConstraints {
    [_imgView makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(FMImageEyeCellSize);
        make.center.equalTo(self);
    }];
    
    [super updateConstraints];
}

/** 绑定ViewModel */
- (void)fm_bindViewModel {
    @weakify(self)
//    [RACObserve(self, pictureModel) subscribeNext:^(FMImageEyeModel *pictureModel) {
//        @strongify(self)
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:pictureModel.imgurl]];
//    }];
    [RACObserve(self, imgUrlString) subscribeNext:^(NSString *imgUrlString) {
        @strongify(self)
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlString]];
    }];
};

@end
