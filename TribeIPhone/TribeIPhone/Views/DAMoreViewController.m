//
//  DASettingViewController.m
//  tribe
//
//  Created by 李 林 on 2012/12/05.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAMoreViewController.h"
#import "DAFileViewController.h"
#import "DAMemberMoreContainerViewController.h"
#import "DASettingContainerViewController.h"
#import "DAShortmailViewController.h"
#import <TribeSDK/DALoginModule.h>

@interface DAMoreViewController ()

@end

@implementation DAMoreViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3; // セクションは2個とします
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DAMoreViewCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            cell.textLabel.text  = @"私信";
            cell.imageView.image = [UIImage imageNamed:@"18-envelope.png"];
        }
        if (1 == indexPath.row) {
            cell.textLabel.text  = @"文书";
            cell.imageView.image = [UIImage imageNamed:@"44-shoebox.png"];
        }
        if (2 == indexPath.row) {
            cell.textLabel.text  = @"账户";
            cell.imageView.image = [UIImage imageNamed:@"man.png"];
        }
    }
    
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            cell.textLabel.text  = @"设定";
            cell.imageView.image = [UIImage imageNamed:@"preferences.png"];
        }
    }
    
    if (2 == indexPath.section) {
        cell.textLabel.text = @"版本信息";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.imageView.image = [UIImage imageNamed:@"world.png"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        // 私信
        if (0 == indexPath.row) {
            DAShortmailViewController *shortmailViewController = [[DAShortmailViewController alloc]initWithNibName:@"DAShortmailViewController" bundle:nil];
            shortmailViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shortmailViewController animated:YES];
        }
        
        // 文书画面
        if (1 == indexPath.row) {
            DAFileViewController *fileViewController = [[DAFileViewController alloc]initWithNibName:@"DAFileViewController" bundle:nil];
            fileViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fileViewController animated:YES];
        }
        
        // 账户
        if (2 == indexPath.row) {
            DAMemberMoreContainerViewController *memberDetailViewController =[[DAMemberMoreContainerViewController alloc]initWithNibName:@"DAMemberMoreContainerViewController" bundle:nil];
            memberDetailViewController.hidesBottomBarWhenPushed = YES;
            // memberDetailViewController.user = [DALoginModule getLoginUserId];
            
            [self.navigationController pushViewController:memberDetailViewController animated:YES];
        }
    }
    
    if (1 == indexPath.section) {
        // 设定
        if (0 == indexPath.row) {
            DASettingContainerViewController *settingContainerViewController = [[DASettingContainerViewController alloc]initWithNibName:@"DASettingContainerViewController" bundle:nil];
            settingContainerViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingContainerViewController animated:YES];
        }
    }
}

@end
