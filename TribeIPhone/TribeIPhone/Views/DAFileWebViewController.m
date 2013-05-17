//
//  DAFileWebViewController.m
//  TribeIPhone
//
//  Created by mac on 13-5-7.
//  Copyright (c) 2013年 kita. All rights reserved.
//
#import <TribeSDK/TribeSDKHeader.h>
#import "DAFileDetailViewController.h"
#import "DAFileWebViewController.h"
#import "DAFileWebViewController.h"
#import "WTStatusBar.h"
#import "MBProgressHUD.h"
#import "DAHelper.h"

@interface DAFileWebViewController ()
{
    MBProgressHUD *_hud;
}
@end

@implementation DAFileWebViewController
@synthesize webView,fileUrl;

- (void) onCancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Downloading...";
    _hud.color = DAColor;
    
    // 在状态栏显示进度
    [WTStatusBar setProgressBarColor:DAColor];
    [WTStatusBar setStatusText:@"uploading..." animated:YES];
    
    //文件路径
    NSString *m_fileName = [[DAHelper documentPath:fileUrl] stringByAppendingFormat:@".%@",self.fileExt];
    
    NSURL *ssurl = [NSURL fileURLWithPath:m_fileName];
    NSURLRequest *requests = [NSURLRequest requestWithURL:ssurl];
    
    if ([DAHelper isFileExist:m_fileName]) {
        [self.webView loadRequest:requests];
        self.webView.scalesPageToFit = YES;
        
        [WTStatusBar setStatusText:@"done!" timeout:0.5 animated:YES];
    } else {
        [[DAFileModule alloc] downloadFile:fileUrl ext:self.fileExt callback:^(NSError *err, NSString *fileid){
            [self.webView loadRequest:requests];
            self.webView.scalesPageToFit = YES;
            
            [WTStatusBar setStatusText:@"done!" timeout:0.5 animated:YES];
        }];
    }
}

- (void) viewDidUnload{
    [super viewDidUnload];
}  


- (void)webViewDidFinishLoad:(UIWebView *)webView_
{
    [_hud hide:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
