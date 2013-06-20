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

    // 获取document目录的大小，计算占整体百分比
    uint64_t total = [DAHelper totalSpace];
    int cache = [DAHelper fts:[DAHelper documentPath:@"/"]];
    self.prvSpace.progress = cache / total;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 设定服务器地址
}

- (IBAction)didEndOnExit:(id)sender
{
    [((UITextField *)sender) resignFirstResponder];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            [[DALoginModule alloc] logout:^(NSError *error){
                
                // 并清除数据
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.smart.message.userid"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.smart.message.password"];
                
                NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.message.userid"];
                NSLog(@"current user : %@", userid);
            }];
        }
    }

    if (indexPath.section == 2) {
        // 注销
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"NeedsLogin" object:nil]];
        
        NSLog(@"logout");
    }

}

@end
