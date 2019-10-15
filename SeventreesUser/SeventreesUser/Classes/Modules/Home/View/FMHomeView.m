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
#import "FMAnnouncementView.h"
#import "FMMenuView.h"
#import "FMStoreView.h"
#import "FMGoodsView.h"

@interface FMHomeView () <SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchContentView;
@property (nonatomic, weak) FMSearchButtonView *searchButtonView;

@property (weak, nonatomic) IBOutlet UIView *scrollerContentView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (weak, nonatomic) IBOutlet UIView *textScrollContentView;
@property (strong, nonatomic) FMAnnouncementView *announcementView;

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
    [_announcementView makeConstraints:^(MASConstraintMaker *make) {
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
    
    /// 图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:_scrollerContentView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholderIcon"]];
    _cycleScrollView = cycleScrollView;
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    [_scrollerContentView addSubview:cycleScrollView];
    
    /// 公告跑马灯
    _announcementView = [[FMAnnouncementView alloc] initWithFrame:_textScrollContentView.bounds];
    [_textScrollContentView addSubview:_announcementView];
    
    /*
    /// 公告跑马灯
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

    //公告测试数据
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"这是最后一条数据："];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"icon_ advertising"]; // test
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:attrStr.length];
    // test
    textScrollView.textDataArr = @[@"这是一条数据：000000",@"这是一条数据：111111",@"这是一条数据：222222",@"这是一条数据：333333",@"这是一条数据：444444",@"这是一条数据：555555",attrStr];
    
    [_textScrollView startScrollBottomToTopWithNoSpace];
    */
    
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

- (void)fm_bindViewModel {
    @weakify(self)
    
    [self.viewModel.refreshUISubject subscribeNext:^(FMHomeModel *homeModel) {
        @strongify(self)     if (!self) return;
        
        self->_cycleScrollView.imageURLStringsGroup = homeModel.pictureURLStrings;
        
        self->_menuView.viewModel.menuEntitys = homeModel.menuModels;
        
        self->_storeView.viewModel.storeModel = homeModel.storeModel;
    }];
    
    [self->_menuView.viewModel.itemActionSubject subscribeNext:^(NSString *code) {
        
        DLog(@"点了菜单：code == %@", code);
    }];
    
    [self->_storeView.viewModel.chatActionSubject subscribeNext:^(FMHomeStoreModel *storeModel) {
        DLog(@"点了店铺聊天：storeModel == %@", storeModel);
    }];
    
    [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(NSNumber *isExecuting) {
        if ([isExecuting isEqualToNumber:@(YES)]) {
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
            [SVProgressHUD showWithStatus:@"加载中.."];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    [self.viewModel.refreshAnnouncementUISubject subscribeNext:^(id x) {
        @strongify(self)     if (!self) return;
        
    }];
}

#pragma mark - Lazyload

- (FMHomeViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMHomeViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"---点击了第%ld张图片", (long)index);

}

- (void)dealloc {
    
}

@end
