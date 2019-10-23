//
//  FMEvaluationCell.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/26.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMEvaluationCell.h"
#import "FMImageEyeListView.h"

@interface FMEvaluationCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nikenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starLevelImgView;

@property (weak, nonatomic) IBOutlet FMImageEyeListView *pictureListView;

@end

@implementation FMEvaluationCell

- (void)fm_bindViewModel {
    @weakify(self)
    
    [RACObserve(self, commentsModel) subscribeNext:^(FMGoodsDetailsCommentsModel *commentsModel) {
        @strongify(self)
        
        [self->_headImgView sd_setImageWithURL:[NSURL URLWithString:commentsModel.userHeadUrl]];
        self->_nikenameLabel.text = commentsModel.userName ?: @"--";
        self->_timeLabel.text = commentsModel.createdDateTime ?: @"--";
        self->_contentLabel.text = commentsModel.content ?: @"";
        self->_starLevelImgView.image = UIImage.ci_imageNamed([NSString stringWithFormat:@"icon_star%@", commentsModel.goodsStar]);
        
        // 预览图片列表
        self->_pictureListView.viewModel.pictureModels = commentsModel.apiPmCommentsImgs;
    }];
}

@end
