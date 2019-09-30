//
//  FMHomeView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMHomeView.h"

#import "FMSearchButtonView.h"
#import "SDCycleScrollView.h"
#import "LMJVerticalScrollText.h"
#import "FMMenuView.h"
#import "FMStoreView.h"
#import "FMGoodsView.h"

@interface FMHomeView () <SDCycleScrollViewDelegate, LMJVerticalScrollTextDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchContentView;
@property (nonatomic, weak) FMSearchButtonView *searchButtonView;

@property (weak, nonatomic) IBOutlet UIView *scrollerContentView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UIView *textScrollContentView;
@property (strong, nonatomic) LMJVerticalScrollText *textScrollView;

@property (weak, nonatomic) IBOutlet UIView *menuContentView;
@property (strong, nonatomic) FMMenuView *menuView;

@property (weak, nonatomic) IBOutlet UIView *storeContentView;
@property (strong, nonatomic) FMStoreView *storeView;

@property (weak, nonatomic) IBOutlet UIView *goodsContentView;
@property (strong, nonatomic) FMGoodsView *goodsView;

@end

@implementation FMHomeView

#pragma mark - Public Functions


#pragma mark - System Functions

- (void)updateConstraints {
    _searchButtonView.cv_frame(CGRectMake(15.f, 11.f, _searchContentView.bounds.size.width - 30.f, 38.f));
    
    [_cycleScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self->_scrollerContentView);
    }];
    
//    _textScrollView.cv_frame(_textScrollContentView.bounds);
    [_textScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self->_textScrollContentView);
        make.size.equalTo(self->_textScrollContentView);
    }];
    
    _menuView.cv_frame(_menuContentView.bounds);
    
    _storeView.cv_frame(_storeContentView.bounds);
    
//    _securityCodeInputView.cv_frame(_inputContentView2.bounds);
    _goodsView.cv_frame(_goodsContentView.bounds);
    
    [super updateConstraints];
}

#pragma mark - Private Functions

- (void)fm_setupSubviews {

    @weakify(self)
    self.cv_addTouchEventCallback(^(UIView *view) {
        self_weak_.cv_endEditing();
    });
    
    /// 搜索栏
    FMSearchButtonView *searchButtonView = FMSearchButtonView.cv_viewFromNibLoad();
    _searchButtonView = searchButtonView;
    [_searchContentView addSubview:searchButtonView];
    
    _searchButtonView.actionCallback = ^{
        DLog(@"点了搜索");
        UIViewController *nextVC = [[NSClassFromString(@"FMSearchPagingController") alloc] init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:nextVC animated:YES];
    };
    
    
    /// 图片轮播器：网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    // test
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_scrollerContentView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
    _cycleScrollView = cycleScrollView;
    [_scrollerContentView addSubview:cycleScrollView];
    
    /// 跑马灯
    CGRect frame = _textScrollContentView.bounds;
    LMJVerticalScrollText *textScrollView = [[LMJVerticalScrollText alloc] initWithFrame:frame];
    _textScrollView = textScrollView;
    [_textScrollContentView addSubview:textScrollView];
    
    textScrollView.delegate            = self;
    textScrollView.textStayTime        = 2;
    textScrollView.scrollAnimationTime = 1;
    textScrollView.textColor           = UIColor.cc_colorByHexString(@"#333333");
    textScrollView.textFont            = [UIFont boldSystemFontOfSize:14.f];
    textScrollView.textAlignment       = NSTextAlignmentLeft;
    textScrollView.touchEnable         = YES;

    // 图片
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"这是最后一条数据："];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"icon_ advertising"]; // test
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:attrStr.length];
    // test
    textScrollView.textDataArr = @[@"这是一条数据：000000",@"这是一条数据：111111",@"这是一条数据：222222",@"这是一条数据：333333",@"这是一条数据：444444",@"这是一条数据：555555",attrStr];
    
    [_textScrollView startScrollBottomToTopWithNoSpace];
    
    /// 菜单s
    FMMenuView *menuView = (FMMenuView *)FMMenuView.cv_viewFromNibLoad();
    _menuView = menuView;
    [_menuContentView addSubview:menuView];
    
    /// 店铺
    FMStoreView *storeView = (FMStoreView *)FMStoreView.cv_viewFromNibLoad();
    _storeView = storeView;
    [_storeContentView addSubview:storeView];
    
    /// 商品列表
    FMGoodsView *goodsView = (FMGoodsView *)FMGoodsView.cv_viewFromNibLoad();
    _goodsView = goodsView;
    [_goodsContentView addSubview:goodsView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)refreshUI {
    
}

#pragma mark - Lazyload



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"---点击了第%ld张图片", (long)index);

}

#pragma mark - LMJScrollTextViewDelegate

- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText currentTextIndex:(NSInteger)index{
//    NSLog(@"当前是信息%ld",index);
}
- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText clickIndex:(NSInteger)index content:(NSString *)content{
//    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
}

- (void)dealloc {
    
}

@end
