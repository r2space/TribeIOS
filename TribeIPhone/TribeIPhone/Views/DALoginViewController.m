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
    // Alert 显示延迟1秒
    NSTimeInterval delay = 1;
    // Alert 竖直偏移
    CGFloat yOffset = 10.f;
    
    // 检证userId是否为空，去掉前后的半角和全角空格
    NSString * userId = [self.txtUserId.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" 　" ]];
    if ( userId.length  == 0) {
        [DAHelper alert:self.view message:@"账户不能为空" detail:nil delay:delay yOffset:yOffset];
        [self.txtUserId becomeFirstResponder];
        return;
    }
    
    // 检证password是否为空，去掉前后的半角和全角空格
    NSString * password = [self.txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" 　" ]];
    if ( password.length  == 0) {
        [DAHelper alert:self.view message:@"密码不能为空" detail:nil delay:delay yOffset:yOffset];
        [self.txtPassword becomeFirstResponder];
        return;
    }
    
    // Blocks版
    [[DALoginModule alloc] login:userId password:password callback:^(NSError *error, DAUser *user){

        // 登陆失败
        if ( user == nil) {
            [DAHelper alert:self.view message:@"用户名或密码不正确！" detail:@"登陆验证失败" delay:delay yOffset:yOffset];
            [self.txtUserId becomeFirstResponder];
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"jp.co.dreamarts.smart.message.userid"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"jp.co.dreamarts.smart.message.password"];
        
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
