//
//  DASecondViewController.m
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DAMessageViewController.h"
#import "DAShortmailViewCell.h"
#import "DAShortmailStoryViewController.h"

@interface DAMessageViewController ()
{
    int _content;
    NSArray *_notifications;
    NSArray *theUsers;
    int user_count;
}

@end

@implementation DAMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.navigationController.tabBarItem.badgeValue = @"4";
    UITabBarItem *itemMail = [ self.tabBar.items objectAtIndex:2];
    itemMail.badgeValue = @"2";
    UITabBarItem *itemNotification = [ self.tabBar.items objectAtIndex:3];
    itemNotification.badgeValue = @"5";
    
    [self onCommentClicked:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_content ==3 ) {
        return user_count;
    }else{
        return _notifications.count;
    }
    
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (_content == 2) {
        DANotification *notification = [_notifications objectAtIndex:indexPath.row];
        return [DAMessageCell cellHeightWithMessage:notification.message];
    }
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_content == 3) {
        DAContact *contact = [theUsers objectAtIndex:indexPath.row];
        DAShortmailViewCell *cells = [DAShortmailViewCell initWithMessage:contact  tableView:tableView];
        cells.lblName.text = contact.user.name.name_zh;
        return cells;
    }
    
    
    static NSString *identifier1 = @"DAMessageViewCellComment";
//    static NSString *identifier2 = @"DAMessageViewCellAt";
//    static NSString *identifier3 = @"DAMessageViewCellMail";
    
	UITableViewCell *cell;
    
    DANotification *notification = [_notifications objectAtIndex:indexPath.row];
    switch (_content) {
        case 1:
            cell = [DANotificationCell initWithNotification:notification tableView:tableView];
            break;
        case 2:
            cell = [DAMessageCell initWithMessage:notification.message tableView:tableView];
            break;
        case 3:

            
            
            break;
        case 4:
            cell = [DANotificationCell initWithNotification:notification tableView:tableView];
            break;
            
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            break;
    }
    
    
    return cell;
    
}


- (IBAction)onCommentClicked:(id)sender {
    _content = 1;
    [[DANotificationModule alloc] getNotificationListByType:@"reply" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
        _notifications = notificationList.items;
        [self.tableView reloadData];
    }];
}

- (IBAction)onAtClicked:(id)sender {
    _content = 2;
    [[DANotificationModule alloc] getNotificationListByType:@"at" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
        _notifications = notificationList.items;
        [self.tableView reloadData];
    }];
}

- (IBAction)onMailClicked:(id)sender {
    
    [[DAShortmailModule alloc] getUsers:0 count:20 callback:^(NSError *error, DAContactList *contact){
        theUsers = contact.items;
        user_count = contact.items.count;
        _content = 3;
        [self.tableView reloadData];
    }];
   
}

- (IBAction)onAlertClicked:(id)sender {
    _content = 4;
    [[DANotificationModule alloc] getNotificationListByType:@"invite,remove,follow" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
        _notifications = notificationList.items;
        [self.tableView reloadData];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_content==3) {
        DAShortmailStoryViewController *shortmailStoryViewController =[[DAShortmailStoryViewController alloc]initWithNibName:@"DAShortmailStoryViewController" bundle:nil];
        shortmailStoryViewController.hidesBottomBarWhenPushed = YES;
        shortmailStoryViewController.contact = ((DAUser *)[theUsers objectAtIndex:indexPath.row])._id;
        
        [self.navigationController pushViewController:shortmailStoryViewController animated:YES];
    }


    
}
@end
