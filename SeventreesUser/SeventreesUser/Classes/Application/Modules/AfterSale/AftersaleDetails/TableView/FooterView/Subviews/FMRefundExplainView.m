//
//  FMRefundExplainView.m
//  SeventreesUser
//
//  Created by wushiye on 2019/9/20.
//  Copyright © 2019 Seven trees. All rights reserved.
//

#import "FMRefundExplainView.h"

@interface FMRefundExplainView ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FMRefundExplainView

- (void)setInfoText:(NSString *)infoText {
    _infoText = infoText;
    
    _textView.text = infoText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 0.5f;// 字体的行间距
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:12.f],
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
//    _textView.attributedText = [[NSAttributedString alloc] initWithString:_textView.text attributes:attributes];
}

@end
