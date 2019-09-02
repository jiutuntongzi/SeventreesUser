//
//  ScrollerMenuView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/29.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "ScrollerMenuView.h"

#define     scrollViewH     44.f
#define     viewWidth       self.frame.size.width
#define     viewHeight      self.frame.size.height

@interface ScrollerMenuView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger tagType;
@property (nonatomic, strong) NSArray *tagBtns;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation ScrollerMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setupScrollerMenuView];
}

- (void)setupScrollerMenuView {
    UIColor *normalColor = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f];
    UIColor *selectColor = [UIColor colorWithRed:247.f / 255.f green:111.f / 255.f blue:111.f / 255.f alpha:1.f];
    self.backgroundColor = UIColor.whiteColor;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, viewWidth, scrollViewH)];
    _scrollView = scrollView;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    scrollView.bounces = NO;
    scrollView.alpha = 1.f;
    scrollView.backgroundColor = self.backgroundColor;
    
    UIView *tagBtnContainerView = [[UIView alloc] init];
    CGFloat tagBtnW = viewWidth / 4.0f;
    CGFloat tagBtnH = scrollViewH - 2.0;
    //默认              收藏              销量             价格
    NSArray *tagTitles = @[@{@(0) : @"默认"}, @{@(1) : @"收藏"}, @{@(2) : @" 销量"}, @{@(3) : @" 价格"}];
    NSMutableArray *mTagBtns = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSInteger index = 0; index != tagTitles.count; index++) {
        NSDictionary *tagTitleDict = tagTitles[index];
        NSString *tagTitle = nil;
        NSInteger tag = 0;
        for (NSString *key in tagTitleDict) {
            tagTitle = tagTitleDict[key];
            tag = key.integerValue;
        }
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.tag = tag;
        [tagBtn setTitle:tagTitle forState:UIControlStateNormal];
        [tagBtn setTitleColor:normalColor forState:UIControlStateNormal];
        [tagBtn setTitleColor:selectColor forState:UIControlStateSelected];
        
        if (index == 2 || index == 3) {
            UIImage *normalImg = [[UIImage imageNamed:@"icon_store_rank_down"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIImage *selectedImg = [[UIImage imageNamed:@"icon_store_rank_up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            [tagBtn setImage:normalImg forState:UIControlStateNormal];
            [tagBtn setImage:selectedImg forState:UIControlStateSelected];
        }
        
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        tagBtn.frame = CGRectMake(index * tagBtnW, 0.0, tagBtnW, tagBtnH);
        [mTagBtns addObject:tagBtn];
        
        [tagBtnContainerView addSubview:tagBtn];
    }
    _tagBtns = [mTagBtns copy];

    NSLog(@"tagTitles.count == %ld", tagTitles.count);
    CGFloat containerViewWidth = tagTitles.count * tagBtnW;
    scrollView.contentSize = CGSizeMake(containerViewWidth, 0);
    tagBtnContainerView.frame = CGRectMake(0, 0, containerViewWidth, tagBtnH);
    tagBtnContainerView.backgroundColor = [UIColor clearColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0, scrollViewH - 2.0, containerViewWidth, 2.0)];
//    lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    lineView.backgroundColor = UIColor.whiteColor;
    [tagBtnContainerView addSubview:lineView];
    
    UIButton *firstBtn = self.tagBtns.firstObject;
    _tagType = firstBtn.tag;
    
    [firstBtn setTitleColor:selectColor forState:UIControlStateNormal];
    _indicatorView = [[UIView alloc] init];
    [_indicatorView setBackgroundColor:selectColor];
    _indicatorView.frame = CGRectMake(firstBtn.frame.origin.x, firstBtn.bounds.size.height, firstBtn.bounds.size.width, 2.0);
     [self selectCurMenuWithTagType:firstBtn.tag];
    
    [tagBtnContainerView addSubview:_indicatorView];
    [scrollView addSubview:tagBtnContainerView];
    [self addSubview:scrollView];
}

- (void)tagBtnClick:(UIButton *)tagBtn {
    UIColor *normalColor = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1.f];
    for (UIButton *tagBtn in self.tagBtns) {
        [tagBtn setTitleColor:normalColor forState:UIControlStateNormal];
    }
    UIColor *selectColor = [UIColor colorWithRed:247.f / 255.f green:111.f / 255.f blue:111.f / 255.f alpha:1.f];
    [tagBtn setTitleColor:selectColor forState:UIControlStateNormal];
    CGFloat tagBtnW = tagBtn.frame.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        self->_indicatorView.frame = CGRectMake(tagBtn.frame.origin.x, scrollViewH - 2.0, tagBtnW, 2.0);
    }];
    
    //使scrollView中心点与内容子视图处在同一坐标系的
    CGFloat equalCenterX = _scrollView.center.x + _scrollView.contentOffset.x;
    //获取滚动范围 btn中心位置与scrollView中心位置的差
    CGFloat h_rollRange = tagBtn.center.x - equalCenterX;
    
    //累加这段范围 （当这段范围超过content可以滚动的范围时 scrollView内部会将contentOffset置为0)
    CGFloat h_roolRangeMax = (CGFloat)self.tagBtns.count * tagBtnW - viewWidth;
    CGPoint currentOffset = _scrollView.contentOffset;
    currentOffset.x += h_rollRange;
    currentOffset.y = 0.0;
    if (currentOffset.x < 0.0) {
        currentOffset.x = 0.0;
    } else if (currentOffset.x > h_roolRangeMax) {
        currentOffset.x = h_roolRangeMax;
    }
    [_scrollView setContentOffset:currentOffset animated:YES];
    
    // 加载刷新各类别的榜单歌曲Cell
    _tagType = tagBtn.tag;
}

- (void)selectCurMenuWithTagType:(NSInteger)tagType {
    
}

@end
