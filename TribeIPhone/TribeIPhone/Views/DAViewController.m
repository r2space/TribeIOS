//
//  DAViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DAViewController.h"
#import "DALoginViewController.h"

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


@end
