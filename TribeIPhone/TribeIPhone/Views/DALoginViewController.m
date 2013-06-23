//
//  DALoginViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DALoginViewController.h"
#import "DATimeLineViewController.h"
#import "DAMainViewController.h"

@interface DALoginViewController ()

@end

@implementation DALoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设定背景颜色
    UIImage *backgroundImage = [UIImage imageNamed:@"4.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    // 注册键盘显示的Notification
    [self registerForKeyboardNotifications];

    // 隐藏状态栏
    // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

// 绑定键盘显示和关闭Notification
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // 480为iPhone4画面高度，超过480则为iphone5画面高度
    CGFloat f = [[UIScreen mainScreen] bounds].size.height > 480 ? 30 : 70;
    CGRect r = self.view.frame;

    // 上移View
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(r.origin.x, r.origin.y - f, r.size.width, r.size.height);
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    // 480为iPhone4画面高度，超过480则为iphone5画面高度
    CGFloat f = [[UIScreen mainScreen] bounds].size.height > 480 ? 30 : 70;
    CGRect r = self.view.frame;

    // 下移View
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(r.origin.x, r.origin.y + f, r.size.width, r.size.height);
    }];
}

// 收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)onLoginTouched:(id)sender
{
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
        DAMainViewController *controller = (DAMainViewController *)self.parentViewController;
        UINavigationController *navigationController = [controller.viewControllers objectAtIndex: 0];
        controller.selectedViewController = navigationController;
        
        // 刷新数据
        DATimeLineViewController *timeLineViewController = [navigationController.viewControllers objectAtIndex:0];
        [timeLineViewController fetch];
        
        // 更新APN通知用设备ID
        [self updateDeviceToken:user._id];
    }];
}

- (void) updateDeviceToken:(NSString *)uid
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.message.devicetoken"];
    
    if (token) {
        DAApns *apn = [[DAApns alloc] init];
        apn.deviceowner = uid;
        apn.devicetoken = token;
        
        [[DANotificationModule alloc] updateDeviceToken:apn callback:^(NSError *error, DAApns *apn){
            [self.view removeFromSuperview];
            NSLog(@"%@", apn);
        }];
    } else {
        [self.view removeFromSuperview];
    }
}

@end
