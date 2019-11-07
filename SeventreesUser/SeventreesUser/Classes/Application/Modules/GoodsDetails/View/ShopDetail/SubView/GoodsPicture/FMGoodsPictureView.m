//
//  FMGoodsPictureView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/3.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMGoodsPictureView.h"
#import "SDCycleScrollView.h"

const CGFloat FMGoodsPictureViewHeight = 400.f;

@interface FMGoodsPictureView () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, copy) NSArray<NSString *> *imageURLStrings;


@end

@implementation FMGoodsPictureView

- (void)fm_setupSubviews {
    [self setupCycleScrollView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

/** SD图片轮播器 */
- (void)setupCycleScrollView {
    
    /// 图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0.f, 0.f, SCREEN_W, FMGoodsPictureViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_scrollerContentView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.autoScroll = NO;
    
    _cycleScrollView = cycleScrollView;
    [self addSubview:cycleScrollView];
    
    self.cv_backColor(UIColor.whiteColor);
}

#pragma mark - System Functions

- (void)updateConstraints {
    [_cycleScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [RACObserve(self, pictureModels) subscribeNext:^(NSArray<FMGoodsDetailsShowImagesModel *> *pictureModels) {
        @strongify(self);
        /// 处理商品轮滚图片
        NSMutableArray *imageURLStrings = [[NSMutableArray alloc] initWithCapacity:5];
        for (FMGoodsDetailsShowImagesModel *pictureModel in pictureModels) {
            [imageURLStrings addObject:pictureModel.url];
        }
        self->_imageURLStrings = [imageURLStrings copy];
        self->_cycleScrollView.imageURLStringsGroup = imageURLStrings;
    }];
    
    // test
    //    NSArray *imagesURLStrings = @[
    //                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
    //                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
    //                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
    //                                  ];
}

@end
