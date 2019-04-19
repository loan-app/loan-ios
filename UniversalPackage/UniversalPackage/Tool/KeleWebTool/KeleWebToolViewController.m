//
//  KeleWebToolViewController.m
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/3.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//


#import "KeleWebToolViewController.h"
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"
#import "NoInputAccessoryView.h"
#import "LoginViewController.h"
#import "RealNameViewController.h"
#import "FaceViewController.h"
#import "KelePersonViewController.h"
#import "FeedBackViewController.h"
#import "MoxieSDK.h"
#import "BaseTabBarViewController.h"
@interface KeleWebToolViewController ()<WKScriptMessageHandler,WKNavigationDelegate, WKUIDelegate, UIGestureRecognizerDelegate,MoxieSDKDelegate>{
    WKUserContentController * userContentController;
}
@property (nonatomic, strong) WKWebView * wkWebView;
@property (nonatomic, strong) UIProgressView  *progressView;
@property (copy,nonatomic) NSString   *webstatus;
@end
@implementation KeleWebToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
    [self initProgressView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (userContentController) {
        [userContentController removeAllUserScripts];
        NSString *cookie;
        if (isValidStr([BaseTool getToken])) {
            cookie = [NSString stringWithFormat:@"%@=%@", @"token", [BaseTool getToken]];
        }else{
            cookie = [NSString stringWithFormat:@"%@=%@", @"token", @""];
        }
        WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource: [NSString stringWithFormat:@"document.cookie = '%@';", cookie] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        NSString *devicecookie = [NSString stringWithFormat:@"%@=%@|%@|%@|%@|%@", @"device", kAliasName,[KeleDeviceInfoTool getiPhoneDevice],[KeleDeviceInfoTool getPhoneDiskSapce], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[KeleDeviceInfoTool getUDID]];
        WKUserScript *decicecookieScript = [[WKUserScript alloc] initWithSource: [NSString stringWithFormat:@"document.cookie = '%@';", devicecookie] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:decicecookieScript];
    }
    [self reloadUrl];
}
- (void)reloadUrl {
    _webstatus = kisToken ? @"1" : @"0";
    if (isValidStr(self.loadUrlString)) {
        NSString *status = [kuserdefaults objectForKey:self.loadUrlString];
        if ( ![status isEqualToString:_webstatus] ) {
            [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrlString]]];
        }
        [kuserdefaults setObject:_webstatus forKey:self.loadUrlString];
    }
}
#pragma mark - 初始化initWk

- (void)initWKWebView {
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:self.wkWebView];
}

- (void)initProgressView {
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kWidth, 2)];
    progressView.tintColor = UIColorFromRGB(0xFF8551);
    progressView.trackTintColor = kWhiteColor;
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userCC = configuration.userContentController;
        [userCC addScriptMessageHandler:kwebSelf  name:kGetTokenWeb];
        [userCC addScriptMessageHandler:kwebSelf  name:kcloseAndOpen];
        [userCC addScriptMessageHandler:kwebSelf  name:@"skipPage"];
        [userCC addScriptMessageHandler:kwebSelf  name:@"getDevice"];
        userContentController = userCC;
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 10.0;
        configuration.preferences = preferences;
        CGFloat bottomHiehgt;
        if (self.navigationController.viewControllers.count == 1) {
            bottomHiehgt = BntAltitude(49);
        }else{
            bottomHiehgt = 0;
        }
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0 , kNavBarHeight, kWidth, kHeight - kNavBarHeight - bottomHiehgt) configuration:configuration];
        _wkWebView.backgroundColor = [UIColor clearColor];
        _wkWebView.allowsBackForwardNavigationGestures = NO;
        _wkWebView.navigationDelegate = self;
        //监听弹出框
        _wkWebView.UIDelegate = self;
        //侧滑返回上一级
        NSInteger VCcount = self.navigationController.viewControllers.count;
        if (VCcount<=1) {
            [_wkWebView setAllowsBackForwardNavigationGestures:false];
        }else{
            [_wkWebView setAllowsBackForwardNavigationGestures:true];
        }
        //隐藏键盘上的工具条
        [NoInputAccessoryView removeInputAccessoryViewFromWKWebView:self.wkWebView];
        // 当拖动时移除键盘
        _wkWebView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
        longPress.delegate = self;
        longPress.minimumPressDuration = 0.3;
        [_wkWebView addGestureRecognizer:longPress];
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self URLEncodeString:self.loadUrlString]]]];
    }
    return _wkWebView;
}
#pragma mark urlstr 转码 ***** ;
-(NSString *)URLEncodeString:(NSString *)oldstr{
    if ([oldstr containsString:@"?"]) {
        NSRange range = [oldstr rangeOfString:@"?"]; //现获取要截取的字符串位置
        NSString * urlStr = [oldstr substringToIndex:range.location]; //截取不需要编译字符串
        NSString * result = [oldstr substringFromIndex:range.location]; //截取需要编译字符串
        NSString *encodedString = [result stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *newStr = [NSString stringWithFormat:@"%@%@",urlStr,encodedString];
        return newStr;
    }
    return oldstr;
}

#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.wkWebView) {
            self.BaseNavgationBar.title = self.wkWebView.title;
        }
        else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    kWeakSelf(self);
    if ([message.name isEqualToString:kcloseAndOpen]) {
        NSNumber * backType = message.body[@"type"];
        //关闭当前页
        if ([backType isEqualToNumber:@0]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新UI操作
                [weakself.navigationController popViewControllerAnimated:YES];
            });
        }
        //登录
        if ([backType isEqualToNumber:@1]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"h5" forKey:@"judgeKey"];
            [BaseTool loginOutUser];
            LoginViewController * loginVC = [[LoginViewController alloc] init];
            [weakself.navigationController pushViewController:loginVC animated:YES];
            
        }
        //首页
        if ([backType isEqualToNumber:@2]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //更新UI操作
                [weakself.navigationController popViewControllerAnimated:YES];
            });
            BaseTabBarViewController * tabbar = (BaseTabBarViewController *)self.tabBarController;
            tabbar.selectedIndex = 0;
            if (self.navigationController.viewControllers.count > 1) {
                [[kAppDelegate getCurrentUIVC].navigationController popToRootViewControllerAnimated:YES];
            }
        }
        //        //我的
        //        if ([backType isEqualToNumber:@3]) {
        //            BaseTabBarController * tabbar = (BaseTabBarController *)self.tabBarController;
        //            tabbar.selectedIndex = 3;
        //
        //            if (self.navigationController.viewControllers.count > 1) {
        //                [self.navigationController popToRootViewControllerAnimated:YES];
        //            }
        //        }
        //意见反馈
        if ([backType isEqualToNumber:@4]) {
            if (kisToken) {
                FeedBackViewController * feedBackVC = [[FeedBackViewController alloc] init];
                [[kAppDelegate getCurrentUIVC].navigationController pushViewController:feedBackVC animated:YES];
            }else {
                LoginViewController * loginVC = [[LoginViewController alloc] init];
                [[kAppDelegate getCurrentUIVC].navigationController popToViewController:loginVC animated:YES];
            }
            NSLog(@"loginIn");//意见反馈
        }
        //实名认证
        if ([backType isEqualToNumber:@5]) {
            RealNameViewController * realNameVC = [[RealNameViewController alloc] init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.navigationController pushViewController:realNameVC animated:YES];
            });
        }
        //人脸
        if ([backType isEqualToNumber:@6]) {
            FaceViewController * faceVC = [[FaceViewController alloc] init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.navigationController pushViewController:faceVC animated:YES];
            });
        }
        if ([backType isEqualToNumber:@7]) {
            KelePersonViewController * mlPersonVC = [[KelePersonViewController alloc] init];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.navigationController pushViewController:mlPersonVC animated:YES];
            });
        }
        if ([backType isEqualToNumber:@8]) {
            //手机认证
            [self configMoxieSDKWithONRecycle:@0];
        }
        //支付宝
        if ([backType isEqualToNumber:@9]) {
            //支付宝
            [self configMoxieSDKWithONRecycle:@1];
        }
    }
    if ([message.name isEqualToString:kGetTokenWeb]) {
        
        
        NSLog(@"get token");
    }
    if ([message.name isEqualToString:@"skipPage"]) {
        if ([message.body[@"isclose"] isEqualToNumber:@0]) {
            if (isValidStr(message.body[@"url"])) {
                KeleWebToolViewController * webViewC = [[KeleWebToolViewController alloc] init];
                webViewC.loadUrlString = message.body[@"url"];
                [self.navigationController pushViewController:webViewC animated:YES];
            }
        }else {
            if (isValidStr(message.body[@"url"])) {
                [self.navigationController popViewControllerAnimated:YES];
                KeleWebToolViewController * findViewC = [[KeleWebToolViewController alloc] init];
                findViewC.loadUrlString = message.body[@"url"];
                [self.navigationController pushViewController:findViewC animated:YES];
            }
        }
    }
    
    
    
}
#pragma mark -左侧按钮事件

- (void)didClickLeftBarButtonItem {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/**
 * 魔蝎SDk
 **/
-(void)configMoxieSDKWithONRecycle:(NSNumber *)index{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = [BaseTool getUserId];
    [MoxieSDK shared].apiKey = kMoxieApiKey;
    [MoxieSDK shared].quitOnLoginDone = YES;
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].phone = [BaseTool getUserMobile];
    [self carrierImportClick:index];
}
- (void)carrierImportClick:(NSNumber *)indexNumber{
    if ([indexNumber isEqualToNumber:@0]) {
        [MoxieSDK shared].taskType = @"carrier";//运营商
    }else if ([indexNumber isEqualToNumber:@1]) {
        [MoxieSDK shared].taskType = @"alipay";//支付宝
    }
    [MoxieSDK shared].quitOnLoginDone = YES;
    [MoxieSDK shared].backImageName = @"ic_back";
    [MoxieSDK shared].themeColor = kyellowColor;
    [MoxieSDK shared].hideRightButton = YES;
    if ([indexNumber isEqualToNumber:@0]) {
        [self configSearchIdRewordIdentifyWithWebview];
    }else {
        [[MoxieSDK shared] start];
    }
}
- (void)configSearchIdRewordIdentifyWithWebview {
    [[NetworkUtils sharedInstance] rewordRealNameutilSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            [MoxieSDK shared].name = response[@"data"][@"userName"];
            [MoxieSDK shared].idcard = response[@"data"][@"userCertNo"];
        }
        [[MoxieSDK shared] start];
    } utilsFail:^(NSString *error) {
        
    }];
}

#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    int code = [resultDictionary[@"code"] intValue];
    
    //用户没有做任何操作
    if(code == -1){
        NSLog(@"用户未进行操作");
    }
    //假如code是2则继续查询该任务进展
    else if(code == 2){
        NSLog(@"任务进行中，可以继续轮询");
    }
    //假如code是1则成功
    else if(code == 1){
        NSLog(@"-------------任务成功");
    }
    //该任务失败按失败处理
    else{
        NSLog(@"任务失败");
    }
    NSLog(@"任务结束，可以根据taskid，在租户管理系统查询该次任何的最终数据，在魔蝎云监控平台查询该任务的整体流程信息。SDK只会回调状态码及部分基本信息，完整数据会最终通过服务端回调。（记得将本demo的apikey修改成公司对应的正确的apikey）");
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return NO;
}

#pragma mark -----  webDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [MBProgressHUD bnt_indeterminateWithMessage:@"" toView:self.view];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [MBProgressHUD hideHUDView:self.view];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD showError:@"加载失败" toView:self.view];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (error.code == NSURLErrorNotConnectedToInternet) {
        
        /// 无网络(APP第一次启动并且没有得到网络授权时可能也会报错)
        
    } else if (error.code == NSURLErrorCancelled){
        /// -999 上一页面还没加载完，就加载当下一页面，就会报这个错。
        return;
    }
}

/**
 * wkwebView 默认禁止打开appstore 唤醒电话 等需要手动实现 ,此外 wkwebview 默认禁止js的弹出框,需要实现<UIdelegate>
 */

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //     1 在发送请求之前，决定是否跳转 /*去掉所有_blank标签*/
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    }
    NSURL *url = navigationAction.request.URL;
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.absoluteString containsString:@"https://www.kaola.com"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否离开当前app前往网易考拉" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            decisionHandler(WKNavigationActionPolicyCancel);
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            decisionHandler(WKNavigationActionPolicyAllow);
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        //     打开appstore
        if ([url.absoluteString containsString:@"//itunes.apple.com/"])
        {
            if ([app canOpenURL:url])
            {
                //设备系统为IOS 10.0或者以上的
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    //设备系统为IOS 10.0以下的
                    [app openURL:url];
                }
                decisionHandler(WKNavigationActionPolicyCancel);
                return;
            }
            
        }else if (url.scheme && ![url.scheme hasPrefix:@"http"]) {
            
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                //设备系统为IOS 10.0以下的
                [app openURL:url];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if ([url.scheme isEqualToString:@"tel"]) {
            NSString *resourceSpecifier = [url resourceSpecifier];
            
            NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
            
            /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                //设备系统为IOS 10.0或者以上的
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
                } else {
                    //设备系统为IOS 10.0以下的
                    [app openURL:url];
                }
            });
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }else if ([url.scheme isEqualToString:@"sms"] || [url.scheme isEqualToString:@"mailto"]) {
            //设备系统为IOS 10.0或者以上的
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                //设备系统为IOS 10.0以下的
                [app openURL:url];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    //读取wkwebview中的cookie 方法1
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        NSLog(@"wkwebview中的cookie:%@", cookie);
    }
    
    //看看存入到了NSHTTPCookieStorage了没有
    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar2 cookies]) {
        NSLog(@"NSHTTPCookieStorage中的cookie%@", cookie);
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}


//警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
//确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
//输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
    [[self.wkWebView configuration].userContentController removeScriptMessageHandlerForName:kGetTokenWeb];
    [[self.wkWebView configuration].userContentController removeScriptMessageHandlerForName:kcloseAndOpen];
    [[self.wkWebView configuration].userContentController removeScriptMessageHandlerForName:@"skipPage"];
    [[self.wkWebView configuration].userContentController removeScriptMessageHandlerForName:@"getDevice"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}


@end
