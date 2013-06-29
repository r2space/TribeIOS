//
//  DASettingViewController.m
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DASettingViewController.h"
#import "DAHelper.h"

#define kInfoPlistKeyServerAddress  @"ServerAddress"
#define kInfoPlistKeyServerPort     @"ServerPort"

@interface DASettingViewController ()

@end

@implementation DASettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *serverAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerAddress];
    NSNumber *serverPort = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerPort];
    
    self.txtServerAddress.text = serverAddress;
    self.txtServerPort.text = [serverPort stringValue];
    self.lblVersion.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [self showFreeSpace];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 离开页面时，设定服务器地址
    [[NSUserDefaults standardUserDefaults] setObject:self.txtServerAddress.text forKey:kServerAddress];
    [[NSUserDefaults standardUserDefaults] setInteger:self.txtServerPort.text.intValue forKey:kServerPort];
}

// 收键盘
- (IBAction)didEndOnExit:(id)sender
{
    [((UITextField *)sender) resignFirstResponder];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            
            UIActionSheet *as = [[UIActionSheet alloc] init];
            as.delegate = self;
            as.title = [DAHelper localizedStringWithKey:@"setting.confirmClearCache" comment:@"确定删除吗？"];
            [as addButtonWithTitle:[DAHelper localizedStringWithKey:@"btn.ok" comment:@"确定"]];
            [as addButtonWithTitle:[DAHelper localizedStringWithKey:@"btn.cancel" comment:@"取消"]];
            as.cancelButtonIndex = 1;
            as.destructiveButtonIndex = 1;
            [as showInView:self.view];
            
            // 并清除数据
            [DAHelper removeAllFile:@"/"];
        }
    }

    // 注销
    if (indexPath.section == 2) {
        [[DALoginModule alloc] logout:^(NSError *error){
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.smart.message.userid"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.smart.message.password"];
            
            // 显示登陆画面
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"NeedsLogin" object:nil]];
        }];
    }

}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            [DAHelper removeAllFile:[DAHelper documentPath:@"/"]];
            [self showFreeSpace];
            break;
        case 1:
            break;
    }
    
}

- (void)showFreeSpace
{
    // 获取document目录的大小，计算占整体百分比
    uint64_t total = [DAHelper totalSpace];
    int cache = [DAHelper fts:[DAHelper documentPath:@"/"]];
    self.prvSpace.progress = cache / total;
}

@end
