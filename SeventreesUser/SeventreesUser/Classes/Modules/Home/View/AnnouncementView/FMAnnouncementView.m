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
    
    [_textScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
}

- (void)fm_bindViewModel {
    // 公告富文本测试数据
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:@"这是最后一条数据："];
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@"icon_ advertising"]; // test
    textAttachment.bounds = CGRectMake(0, -4, 15, 15);
    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attrStr insertAttributedString:attachmentAttrStr atIndex:attrStr.length];
    // test
    _textScrollView.textDataArr = @[@"这是一条数据：000000",@"这是一条数据：111111",@"这是一条数据：222222",@"这是一条数据：333333",@"这是一条数据：444444",@"这是一条数据：555555",attrStr];
    
    [_textScrollView startScrollBottomToTopWithNoSpace];
}

- (FMAnnouncementViewModel *)viewModel {
    if (! _viewModel) {
        _viewModel = [[FMAnnouncementViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark - LMJScrollTextViewDelegate

- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText currentTextIndex:(NSInteger)index{
    //    NSLog(@"当前是信息%ld",index);
}
- (void)verticalScrollText:(LMJVerticalScrollText *)scrollText clickIndex:(NSInteger)index content:(NSString *)content{
    //    NSLog(@"#####点击的是：第%ld条信息 内容：%@",index,content);
}

@end
