//
//  DialogBoxView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/8/19.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "DialogBoxView.h"

@interface DialogBoxView ()

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *affirmTitle;

@property (nonatomic, assign) DialogBoxViewStyle style;

@property (nonatomic, copy) NSString *inputText;

@property (nonatomic, copy) void(^affirmCallback)(NSString * __nullable) ;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIView *inputContentView;
@property (weak, nonatomic) IBOutlet UILabel *hintMsgLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *affirmButton;
@property (weak, nonatomic) IBOutlet UIButton *iSeeButton;

@property (weak, nonatomic) IBOutlet UIView *affirmContentView;
@property (weak, nonatomic) IBOutlet UIView *hintContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewHeightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewCenterYCons;


@end

@implementation DialogBoxView

#pragma mark ——— Action

- (IBAction)dismissButtonOnTouch:(id)sender {
    [self dismiss];
}

- (IBAction)affirmButtonOnTouch:(id)sender {
    if (_affirmCallback) _affirmCallback(_textField.text);
    [self dismiss];
}
- (IBAction)endEditAction {
    [self endEditing];
}

- (void)endEditing {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)dismiss {
    [self endEditing];
    [self removeFromSuperview];
}

#pragma mark ——— Show

+ (void)showByTitle:(NSString *)title message:(NSString *)message affirmButtonTitle:(NSString *)affirmTitle forStyle:(DialogBoxViewStyle)style affirmHandler:(void(^)(NSString * __nullable))affirmCallback {
    CGRect frame = CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    DialogBoxView *dialogView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    dialogView.frame = frame;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window endEditing:YES];
    [window addSubview:dialogView];
    
    dialogView.style = style;
    dialogView.title = [title copy];
    dialogView.message = [message copy];
    dialogView.affirmTitle = [affirmTitle copy];
    dialogView.affirmCallback = [affirmCallback copy];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.textField addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEndOnExit];
}

#pragma mark ——— Set

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    
    _textView.text = message;
    _hintMsgLabel.text = message;
}

- (void)setAffirmTitle:(NSString *)affirmTitle {
    [_affirmButton setTitle:affirmTitle forState:UIControlStateNormal];
    [_iSeeButton setTitle:affirmTitle forState:UIControlStateNormal];
}

- (void)setStyle:(DialogBoxViewStyle)style {
    _style = style;
    
    /// 默认
    _affirmContentView.hidden = NO;
    _hintContentView.hidden = YES;
    _centerViewHeightCons.constant = 225.f;
    _centerViewCenterYCons.constant = 0.f;
    _textView.hidden = NO;
    _inputContentView.hidden = YES;
    
    if (style == DialogBoxViewStyleHint) {
        _affirmContentView.hidden = YES;
        _hintContentView.hidden = NO;
        
    } else if (style == DialogBoxViewStyleAffirm) {
        
    } else if (style == DialogBoxViewStyleInput) {
        _textView.hidden = YES;
        _inputContentView.hidden = NO;
        _centerViewHeightCons.constant = 175.f;
        _centerViewCenterYCons.constant = -60.f;
    }
}

@end
