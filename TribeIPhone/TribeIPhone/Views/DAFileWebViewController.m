//
//  DAFileWebViewController.m
//  TribeIPhone
//
//  Created by mac on 13-5-7.
//  Copyright (c) 2013年 kita. All rights reserved.
//
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
    NSURL* url = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    //文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *m_fileName = self.downloadId;
    //调整文件名
    if ([self.fileExt isEqualToString:@"jpeg"]) {
        m_fileName = [self.downloadId stringByAppendingString:@".jpg"];
    }else{
        m_fileName = [self.downloadId stringByAppendingFormat:@".%@",self.fileExt];

    }
    //文件的绝对路径
    NSString *m_filePath = [[NSString alloc] initWithString:
                            [directory stringByAppendingPathComponent:m_fileName]];
    if([[NSFileManager defaultManager]fileExistsAtPath:m_filePath]){
        NSURL *ssurl = [NSURL fileURLWithPath:m_filePath];
        NSURLRequest *requests = [NSURLRequest requestWithURL:ssurl];
        [self.webView loadRequest:requests];
        self.webView.scalesPageToFit = YES;
        [WTStatusBar setStatusText:@"done!" timeout:0.5 animated:YES];
    } else {
        NSData   *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        if (data != nil){
            if ([data writeToFile:m_filePath atomically:YES])
            {
                NSURL *ssurl = [NSURL fileURLWithPath:m_filePath];
                NSURLRequest *requests = [NSURLRequest requestWithURL:ssurl];
                [self.webView loadRequest:requests];
                self.webView.scalesPageToFit = YES;
                [WTStatusBar setStatusText:@"done!" timeout:0.5 animated:YES];
            }
            else
            {
            }
        } else {
            NSLog(@"%@", error);
        }
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
//- (void)onFileDetailTouched:(id)sender
//{
//   NSLog(@"FileDetailViewController");
//    DAFileDetailViewController *detailViewController = [[DAFileDetailViewController alloc] initWithNibName:@"DAFileDetailViewController" bundle:nil];
//    detailViewController.getfile = self.fileDb;
//    detailViewController.hidesBottomBarWhenPushed  = YES;
//  [self.navigationController pushViewController:detailViewController animated:YES];
//}

@end
