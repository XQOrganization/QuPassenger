//
//  BaseWebViewController.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/11.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
    [self loadUrlWithString:self.url];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"加载中";
   

}

- (void)initWebView
{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    webView.delegate = self;
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    self.webView = webView;
}

- (void)loadUrlWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSLog(@"webView loadUrl:%@",url);
    
    [self.webView loadRequest:request];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [QuHudHelper mb_dismiss];
    [self.quNavBar setTitle:[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [QuHudHelper mb_loading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [QuHudHelper mb_dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
