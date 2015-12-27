//
//  AboutViewController.m
//  gjdryz
//
//  Created by AllPepole on 15/12/7.
//
//

#import "AboutViewController.h"

@interface AboutViewController ()<UIWebViewDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于";
    [self setNavigationBack];
    self.webView.delegate = self;
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ABOUT_URL]];
    
    [self.webView loadRequest:request];
    [Helper showHud:nil inView:self.webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [Helper hideHudFromView:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
