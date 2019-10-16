//
//  FMAnnouncementView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/10/15.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMAnnouncementView.h"
#import "LMJVerticalScrollText.h"

@interface FMAnnouncementView () <LMJVerticalScrollTextDelegate>

@property (strong, nonatomic) LMJVerticalScrollText *textScrollView;

@end

@implementation FMAnnouncementView

- (void)fm_setupSubviews {
    LMJVerticalScrollText *textScrollView = [[LMJVerticalScrollText alloc] initWithFrame:self.frame];
    _textScrollView = textScrollView;
    [self addSubview:textScrollView];
    
    textScrollView.delegate            = self;
    textScrollView.textStayTime        = 2;
    textScrollView.scrollAnimationTime = 1;
    textScrollView.textColor           = UIColor.cc_colorByHexString(@"#333333");
    textScrollView.textFont            = [UIFont boldSystemFontOfSize:14.f];
    textScrollView.textAlignment       = NSTextAlignmentLeft;
    textScrollView.touchEnable         = YES;
    _textScrollView.textDataArr = @[@" ", @" "]; // 占位内容
    [_textScrollView startScrollBottomToTopWithNoSpace];
    
    [self makeConstraints];
}

- (void)makeConstraints {
    [_textScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
}

- (void)fm_bindViewModel {
    @weakify(self)
    
    [self.viewModel.refreshUISubject subscribeNext:^(NSArray<NSString *> *announcementTitles) {
        @strongify(self)     if (!self) return;
        self->_textScrollView.textDataArr = announcementTitles;
    }];
}

- (FMAnnouncementViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMAnnouncementViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - LMJScrollTextViewDelegate

- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText currentTextIndex:(NSInteger)index{
//        NSLog(@"当前是信息%ld",index);
}
- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText clickIndex:(NSInteger)index content:(NSString *)content{
    FMAnnouncementModel *announcementModel = [self.viewModel.announcementModels ca_objectCheckAtIndex:index];
    DLog(@"点了第%ld条公告内容：%@", index, announcementModel.title);
}

@end
