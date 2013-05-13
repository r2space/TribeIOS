//
//  DALoginViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DALoginViewController.h"
#import "DATimeLineViewController.h"
#import "DAViewController.h"

@interface DALoginViewController ()

@end

@implementation DALoginViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background2.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginTouched:(id)sender {

    // SEL版
    //[[DALoginModule alloc] login:self.txtUserId.text password:self.txtPassword.text target:self success:@selector(loginSuccess:) failure:nil];
    
    // Blocks版
    [[DALoginModule alloc] login:self.txtUserId.text password:self.txtPassword.text callback:^(NSError *error, DAUser *user){

        [[NSUserDefaults standardUserDefaults] setObject:self.txtUserId.text forKey:@"jp.co.dreamarts.smart.message.userid"];
        [[NSUserDefaults standardUserDefaults] setObject:self.txtPassword.text forKey:@"jp.co.dreamarts.smart.message.password"];
        
        // 保存用户数据
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentDir = [paths objectAtIndex:0];
        
        NSData *userdata = [NSKeyedArchiver archivedDataWithRootObject:user];
        [userdata writeToFile:[NSString stringWithFormat:@"%@/%@", documentDir, user._id] atomically:YES];
        
        // 显示第一个消息画面
        DAViewController *controller = (DAViewController *)self.parentViewController;
        UINavigationController *navigationController = [controller.viewControllers objectAtIndex: 0];
        controller.selectedViewController = navigationController;
        
        // 刷新数据
        DATimeLineViewController *timeLineViewController = [navigationController.viewControllers objectAtIndex:0];
        [timeLineViewController showMessages];
        
        NSLog(@"login ok");
        [self.view removeFromSuperview];

    }];
}

//- (void) loginSuccess:(DAUser *)user
//{
//    [[NSUserDefaults standardUserDefaults] setObject:self.txtUserId.text forKey:@"jp.co.dreamarts.smart.message.userid"];
//    [[NSUserDefaults standardUserDefaults] setObject:self.txtPassword.text forKey:@"jp.co.dreamarts.smart.message.password"];
//    
//    // 保存用户数据
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* documentDir = [paths objectAtIndex:0];
//    
//    NSData *userdata = [NSKeyedArchiver archivedDataWithRootObject:user];
//    [userdata writeToFile:[NSString stringWithFormat:@"%@/%@", documentDir, user._id] atomically:YES];
//    
//    // 显示第一个消息画面
//    DAViewController *controller = (DAViewController *)self.parentViewController;
//    UINavigationController *navigationController = [controller.viewControllers objectAtIndex: 0];
//    controller.selectedViewController = navigationController;
//    
//    // 刷新数据
//    DATimeLineViewController *timeLineViewController = [navigationController.viewControllers objectAtIndex:0];
//    [timeLineViewController showMessages];
//    
//    NSLog(@"login ok");
//    [self.view removeFromSuperview];
//}

@end
