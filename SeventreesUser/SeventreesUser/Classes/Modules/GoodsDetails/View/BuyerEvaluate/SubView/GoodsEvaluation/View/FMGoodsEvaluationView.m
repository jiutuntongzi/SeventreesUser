//
//  FMGoodsEvaluationView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsEvaluationView.h"
#import "FMImageEyeListView.h"

const CGFloat FMGoodsEvaluationViewHeight = 206.f;

@interface FMGoodsEvaluationView ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nikenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starLevelImgView;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startWidthCons;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet FMImageEyeListView *pictureListView;

@end

@implementation FMGoodsEvaluationView

@synthesize viewModel = _viewModel;

#pragma mark - Private Functions

//- (void)setViewModel:(FMGoodsEvaluationViewModel *)viewModel {
//    _viewModel = viewModel;
//
//
//}
//
//- (instancetype)initWithViewModel:(id <FMViewModelProtocol>)viewModel {
//    _viewModel = (FMGoodsEvaluationViewModel *)_viewModel;
//
//    return [super initWithViewModel:viewModel];
//}

- (void)fm_setupSubviews {
    self.cv_backColor(UIColor.whiteColor);
    
    self.cv_addTouchEventCallback(^(UIView *view) {
        view.cv_endEditing();
    });
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [RACObserve(self.viewModel, commentsModel) subscribeNext:^(FMGoodsDetailsCommentsModel *commentsModel) {
        @strongify(self)
        
        [self->_headImgView sd_setImageWithURL:[NSURL URLWithString:commentsModel.userHeadUrl]];
        self->_nikenameLabel.text = commentsModel.userName ?: @"--";
        self->_timeLabel.text = commentsModel.createdDateTime ?: @"--";
        self->_contentLabel.text = commentsModel.content ?: @"";
        self->_starLevelImgView.image = UIImage.ci_imageNamed([NSString stringWithFormat:@"icon_star%@", commentsModel.goodsStar]);
//        self->_startWidthCons.constant = commentsModel.goodsStar.integerValue
        
        // 预览图片列表
        self->_pictureListView.viewModel.pictureModels = commentsModel.apiPmCommentsImgs;
    }];
    
    [_pictureListView.viewModel.selectItemSubject subscribeNext:^(FMImageEyeModel *imageEyeModel) {
        @strongify(self)
        [self.viewModel.selectItemSubject sendNext:imageEyeModel];
    }];
}

#pragma mark - System Functions

- (void)updateConstraints {
    
    [super updateConstraints];
}

#pragma mark - Lazyload

- (FMGoodsEvaluationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FMGoodsEvaluationViewModel alloc] init];
    }
    return _viewModel;
}


@end
