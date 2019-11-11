//
//  WebViewController.h
//  thjPaoDekuai_app iOS
//
//  Created by fm on 2019/2/25.
//

#import "FMViewController.h"

typedef NS_ENUM(NSInteger, WebViewControllerPageType) {
    WebViewControllerPageTypeScoreExplain = 1,      // 积分说明
};

@interface WebViewController : FMViewController

+ (void)showByPageType:(WebViewControllerPageType)type;

+ (void)showByURLString:(NSString * __nonnull)URLString;

@end
