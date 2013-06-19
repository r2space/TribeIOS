//
//  DANotificationViewController.m
//  TribeIPhone
//
//  Created by Antony on 13-5-13.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import "DANotificationViewController.h"
#import "DAShortmailViewCell.h"
#import "DAShortmailStoryViewController.h"
#import "DAMessageDetailViewController.h"

@interface DANotificationViewController ()
{
    NotificationType _content;  // 通知的种类
    NSArray *_notifications;
}

@end

@implementation DANotificationViewController

// 返回按钮
- (IBAction)onCancelClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 高亮显示第一个Tab
    [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:0]];

    // 获取[提到我]
    _content = NotificationTypeAt;
    [[DANotificationModule alloc] getNotificationListByType:@"at" start:0 count:20
                                                   callback:^(NSError *error, DANotificationList *notificationList){
        _notifications = notificationList.items;
        [self.tableView reloadData];
    }];
    
    // 显示通知件数
    UITabBarItem *itemMail = [ self.tabBar.items objectAtIndex:2];
    itemMail.badgeValue = @"2";
}

// TabBar选择事件
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    _content = item.tag;
    
    switch (_content) {
        case NotificationTypeAt:// 提到我
        {
            _content = NotificationTypeAt;
            [[DANotificationModule alloc] getNotificationListByType:@"at" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
                _notifications = notificationList.items;
                [self.tableView reloadData];
            }];
            break;
        }
        case NotificationTypeReply:// 评论
        {
            _content = NotificationTypeReply;
            [[DANotificationModule alloc] getNotificationListByType:@"reply" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
                _notifications = notificationList.items;
                [self.tableView reloadData];
            }];
            break;
        }
        case NotificationTypePrivateMessage:// 私信
        {
            _content = NotificationTypePrivateMessage;
            [[DAShortmailModule alloc] getUsers:0 count:20 callback:^(NSError *error, DAContactList *contact){
                _notifications = contact.items;
                [self.tableView reloadData];
            }];
            break;
        }
        case NotificationTypeSystemAlert:// 通知
        {
            [[DANotificationModule alloc] getNotificationListByType:@"invite,remove,follow" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
                _notifications = notificationList.items;
                [self.tableView reloadData];
            }];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _notifications.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_content == NotificationTypePrivateMessage) {
        DAContact *contact = [_notifications objectAtIndex:indexPath.row];
        DAShortmailViewCell *cells = [DAShortmailViewCell initWithMessage:contact  tableView:tableView];
        cells.lblName.text = contact.user.name.name_zh;
        return cells;
    }
    
    DANotification *notification = [_notifications objectAtIndex:indexPath.row];
    DANotificationCell *cell = [DANotificationCell initWithNotification:notification tableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_content == NotificationTypePrivateMessage) {
        DAShortmailStoryViewController *shortmail =[[DAShortmailStoryViewController alloc]initWithNibName:@"DAShortmailStoryViewController" bundle:nil];
        shortmail.hidesBottomBarWhenPushed = YES;
        
        DAContact *contact = ((DAContact *)[_notifications objectAtIndex:indexPath.row]);
        shortmail.contact = contact._id;
        shortmail.uid = contact.user._id;
        shortmail.name = contact.user.name.name_zh;
        
        [self presentViewController:shortmail animated:YES completion:nil];
        return;
    }
    
    DAMessageDetailViewController *detailViewController = [[DAMessageDetailViewController alloc] initWithNibName:@"DAMessageDetailViewController" bundle:nil];
    
    DANotification *notification = [_notifications objectAtIndex:indexPath.row];
    detailViewController.messageId = notification.objectid;
    detailViewController.hidesBottomBarWhenPushed = YES;
    [self presentViewController:detailViewController animated:YES completion:nil];

}

@end
