//
//  FMFeedbackController.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/9.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMFeedbackController.h"
#import "FMFeedbackRecordController.h"

@interface FMFeedbackController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;

@property (nonatomic, weak) IBOutlet UILabel *placeholderLabel;

@property (nonatomic, weak) IBOutlet UILabel *wordCountLabel;

@property (nonatomic, weak) IBOutlet UIButton *commitButton;

@end

@implementation FMFeedbackController

#pragma mark - System Functions

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
}

#pragma mark - Private Functions

- (void)fm_addSubviews {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    _textView.delegate = self;
}

- (void)fm_bindViewModel {
    @weakify(self)
    [[_commitButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        NSLog(@"提交反馈");
        self.view.cv_endEditing();
        
        if (self->_textView.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:@"请输入"];
            return;
        }
        
        if (self->_textView.text.length > 300) {
            [SVProgressHUD showInfoWithStatus:@"输入内容受限"];
            return;
        }
        
        
        
        
    }];
}

- (void)fm_setupNavbar {
    [super fm_setupNavbar];
    
    self.navigationItem.title = @"意见反馈";
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *rightItem = UIBarButtonItem.cbi_initWithTitleStyleForTouchCallback(@"反馈记录", 1, ^(UIBarButtonItem *rightItem) {
        UIViewController *nextVC = [[FMFeedbackRecordController alloc] init];
        weakSelf.navigationController.cnc_pushViewControllerDidAnimated(nextVC, YES);
    });
    self.navigationItem.cni_rightBarButtonItem(rightItem);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = textView.hasText;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    _placeholderLabel.hidden = textView.hasText;
}
- (void)textViewDidChange:(UITextView *)textView {
    _placeholderLabel.hidden = textView.hasText;
    _wordCountLabel.text = [NSString stringWithFormat:@"%ld/300字", textView.text.length];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    DLog(@"销毁了");
}

@end
