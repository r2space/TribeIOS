//
//  DAViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAViewController.h"
#import "DALoginViewController.h"
#import <TribeSDK/DAMacros.h>
#import "MBProgressHUD.h"
#import "DAHelper.h"

@interface DAViewController ()
{
//    DALoginViewController *loginViewController;
}

@end

@implementation DAViewController

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
	// Do any additional setup after loading the view.


    // 注册没有登陆时调用的函数
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(notificationShowLogin:) name:@"NeedsLogin" object:nil];
    [nc addObserver:self selector:@selector(notificationNotReachable:) name:kNoticeNotReachable object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.message.userid"];
    NSLog(@"current user : %@", userid);
    if (userid == nil) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"NeedsLogin" object:nil]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 接受通知
- (void)notificationShowLogin:(NSNotification*)note
{
    // TODO: 动画显示
    DALoginViewController *loginViewController = [[DALoginViewController alloc]initWithNibName:@"DALoginViewController" bundle:nil];
    [loginViewController.view setFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self addChildViewController:loginViewController];
    [self.view addSubview:loginViewController.view];
}

- (void)notificationNotReachable:(NSNotification*)note
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//	
//	hud.dimBackground = YES;
//    
//	hud.mode = MBProgressHUDModeText;
//	hud.labelText = @"无法连接网络";
//	hud.margin = 10.f;
////	hud.yOffset = 150.f;
//	hud.removeFromSuperViewOnHide = YES;
//	
//	[hud hide:YES afterDelay:3];

}

@end
