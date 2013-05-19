//
//  DABaseViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/05/17.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DABaseViewController.h"

@interface DABaseViewController ()

@end

@implementation DABaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 添加Pull To Refresh控件
    if (self.tableView != nil) {
        refresh = [[UIRefreshControl alloc] init];
        refresh.tintColor = DAColor;
        [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
        
        [self.tableView addSubview:refresh];
    }
}

- (BOOL)startFetch
{
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if ([DAHelper isNetworkReachable]) {

        // 网络可达，显示等待
        progress.mode = MBProgressHUDModeIndeterminate;
        progress.labelText = @"Loging...";
        progress.color = DAColor;
        [progress show:YES];

        return NO;
    }
    
    progress.mode = MBProgressHUDModeText;
    progress.dimBackground = YES;
    
    progress.labelText = @"无法连接网络";
    progress.margin = 10.f;
    //	hud.yOffset = 150.f;
    progress.removeFromSuperViewOnHide = YES;
    
    [progress hide:YES afterDelay:3];
    
    [refresh endRefreshing];
    return YES;
}

- (BOOL)finishFetch:(NSError *)error
{
    [progress hide:YES];
    [refresh endRefreshing];
    
    if (error == nil) {
        return NO;
    }
    
    NSLog(@"%@", error);
    
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    progress.dimBackground = YES;
    
    progress.mode = MBProgressHUDModeText;
    progress.labelText = @"无法获取数据";
	progress.detailsLabelText = [NSString stringWithFormat:@"error : %d", [error code]];
    progress.margin = 10.f;
    progress.removeFromSuperViewOnHide = YES;
    
    [progress hide:YES afterDelay:5];
    return YES;
}

- (void)refresh
{
    NSLog(@"请实现DABaseViewController的refresh");
}

@end
