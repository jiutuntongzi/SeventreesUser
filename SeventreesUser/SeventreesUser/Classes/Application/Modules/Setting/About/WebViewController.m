//
//  WebViewController.m
//  thjPaoDekuai_app iOS
//
//  Created by fm on 2019/2/25.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

//---------------------------  WeakWebViewScriptMessageDelegate Calss  ---------------------------------//

#pragma mark - <WKScriptMessageHandler> JS回调消息

@interface WeakWebViewScriptMessageDelegate : NSObject<WKScriptMessageHandler>

//WKScriptMessageHandler 这个协议类专门用来处理JavaScript调用原生OC的方法
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

@implementation WeakWebViewScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

#pragma mark - WKScriptMessageHandler
//遵循WKScriptMessageHandler协议，必须实现如下方法，然后把方法向外传递
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([self.scriptDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end

//---------------------------  WeakWebViewScriptMessageDelegate Calss  ---------------------------------//




//---------------------------  WebViewController Calss  ---------------------------------//

@interface WebViewController () <WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic , strong) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, assign) WebViewControllerPageType type;

@end

@implementation WebViewController

+ (void)showByPageType:(WebViewControllerPageType)type {
    WebViewController *customWebVC = [[WebViewController alloc] init];
    customWebVC.type = type;
    [WebViewController presentToController:customWebVC];
}

+ (void)showByURLString:(NSString * __nonnull)URLString {
    WebViewController *customWebVC = [[WebViewController alloc] init];
    customWebVC.urlString = URLString;
    [WebViewController presentToController:customWebVC];
}

+ (void)presentToController:(UIViewController *)nextVC {
    // [commonMgr.topViewController]
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:nextVC];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:navigationVC animated:YES completion:nil];
}

- (void)setupWKWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    //自定义的WKScriptMessageHandler 是为了解决内存不释放的问题
    WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
    //这个类主要用来做native与JavaScript的交互管理
    WKUserContentController * wkUController = [[WKUserContentController alloc] init];
    
    configuration.userContentController = wkUController;
    
    
    // 创建设置对象
    WKPreferences *preference = [[WKPreferences alloc] init];
    //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
    preference.minimumFontSize = 0;
    //设置是否支持javaScript 默认是支持的
    preference.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preference.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preference;
    
//     //         是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
//     configuration.allowsInlineMediaPlayback = YES;
//     //        设置视频是否需要用户手动播放  设置为NO则会允许自动播放
//     configuration.requiresUserActionForMediaPlayback = YES;
//     //        设置是否允许画中画技术 在特定设备上有效
//     configuration.allowsPictureInPictureMediaPlayback = YES;
//     //        设置请求的User-Agent信息中应用程序名称 iOS9后可用
//     configuration.applicationNameForUserAgent = @"联车宝盒";
 
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.f, 0.0f, SCREEN_W, SCREEN_H) configuration:configuration];
    // 横竖屏自适应
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    webView.UIDelegate = self; // UI代理
    webView.navigationDelegate = self; // 导航代理
    
    self.webView = webView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupWKWebView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    
    if (_type == WebViewControllerPageTypeScoreExplain) {
        self.navigationItem.title = @"积分说明";
    } else if (_type == WebViewControllerPageTypeScoreExplain) {
        self.navigationItem.title = @"积分说明";
    }
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.leftBarButtonItem = [self barButtonItemWithImageName:@"icon_navBack" title:nil action:@selector(backAction) left:YES];
    
    self.navigationItem.rightBarButtonItem = [self barButtonItemWithImageName:nil title:@"刷新" action:@selector(rightNavRefreshButtonAction) left:NO]; // 右
    
    [self.view addSubview:self.progressView];
    
    [self addKeyValueObserving];
}

- (void)rightNavRefreshButtonAction {
    if (! _urlString.length) {
        [SVProgressHUD showErrorWithStatus:@"数据错误：刷新网页失败，URL(nil)"];
        [SVProgressHUD dismissWithDelay:0.5f];
        return;
    }
    [self.webView reload]; // 刷新
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0.f, 0.0f, SCREEN_W, 1.0f)];
        _progressView.tintColor = UIColor.cc_colorByHexString(@"#F76F6F");
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (void)addKeyValueObserving {
    // 添加监测网页加载进度观察者
    [self.webView addObserver:self
                   forKeyPath:NSStringFromSelector(@selector(estimatedProgress))
                      options:0
                      context:nil];
    // 添加网页标题观察者
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
}

// kvo 监听进度 必须实现此方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == _webView) {
        
        self.progressView.progress = _webView.estimatedProgress;
        __weak typeof(self) weakSelf = self;
        if (_webView.estimatedProgress >= 1.0f) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.progressView.progress = 0;
            });
        }
        
    } else if([keyPath isEqualToString:@"title"] && object == _webView) {
        
        self.navigationItem.title = _webView.title;
        
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)evaluateJavaScriptForTrackPlayRunByDateString:(NSString *)dateString {
//    __weak typeof(self) weakSelf = self;
    // OC调用JS  changeColor()是JS方法名，completionHandler是异步回调block
    NSString *javaScriptStr = [NSString stringWithFormat:@"trackPlay_run(\"%@\")", dateString];
    [self.webView evaluateJavaScript:javaScriptStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if (error) {
            DLog(@"OC调用JS错误：error.localizedDescription == %@", error.localizedDescription);
            return;
        }
    }];
}

/** 定制的左右导航按钮 */
- (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName title:(NSString *)title action:(SEL)action left:(BOOL)left {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(0.0f, 0.0f, 70.f, 44.f);
    if (left) { // 左边的
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else { // 右边的
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestLoadData];
}

- (void)requestLoadData {
    __weak typeof(self) weakSelf = self;
    NSInteger type = _type;
    [SVProgressHUD showWithStatus:nil];
    [networkMgr POST:kIntegralExplainHTMLQueryURIPath params:@{@"type": @(type)} success:^(NetworkResultModel *resultModel) {
        [SVProgressHUD dismiss];
        if (![resultModel.statusCode isEqualToString:@"OK"]) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"数据错误：%@", resultModel.statusMsg]];
            [SVProgressHUD dismissWithDelay:0.5f];
            return;
        }
        weakSelf.urlString = [resultModel.jsonDict[@"html"] copy];
        [weakSelf loadRequestWithURLString:weakSelf.urlString];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        [SVProgressHUD dismissWithDelay:0.5f];
    }];
}

- (void)loadRequestWithURLString:(NSString *)URLString {
    //    NSString *url = @"http://h5.99thj.com/h5game/test.html"; // test
    if (!URLString.length) {
        DLog(@"(错误：Request的URL空了) loadUrl -> URLString == %@", URLString);
        [SVProgressHUD showErrorWithStatus:@"URL错误！nil"];
        return;
    }
    NSString *encodedString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:encodedString]];
    [self.webView loadRequest:request];
}


#pragma mark -- WKNavigationDelegate

// 页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
//    [self evaluateJavaScriptForTrackPlayRunByDateString:_selectDateString];
}

// 页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    
}

// 提交发生错误
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    
}

#pragma mark - didReceiveScriptMessage

// 被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
// 通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    DLog(@"didReceiveScriptMessage -> \n message.name:%@ \n message.body:%@ \n message.frameInfo:%@ \n", message.name, message.body, message.frameInfo);
    
    //用message.body获得JS传出的参数体
    NSDictionary *parameter = message.body;
    //JS调用OC
    DLog(@"其它JS脚本消息：message.name == %@ \n parameter == %@", message.name, parameter);
}


// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    DLog(@"当前跳转地址：navigationResponse.response.URL.absoluteString == %@", urlStr);
    if (!urlStr.length) NSLog(@"错误：当前跳转地址nil了!!!");
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

- (void)dealloc{
    // 移除KVOs
    [self.webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self
                  forKeyPath:NSStringFromSelector(@selector(title))];
}

@end


//---------------------------  WebViewController Calss  ---------------------------------//
