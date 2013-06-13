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

@interface DANotificationViewController ()
{
    int _content;
    NSArray *_notifications;
    NSArray *theUsers;
    int user_count;
    
    
}

@end

@implementation DANotificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)onCancelClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _content = 2;
    [[DANotificationModule alloc] getNotificationListByType:@"at" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
        _notifications = notificationList.items;
        [self.tableView reloadData];
    }];
    UITabBarItem *itemMail = [ self.tabBar.items objectAtIndex:2];
    itemMail.badgeValue = @"2";
    self.navigationController.tabBarItem.badgeValue=@"12";
    //向下的收拾 返回上一页
    UISwipeGestureRecognizer *oneFingerSwipeUp =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)] ;
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeUp];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Sent to the delegate when the user selects a tab bar item.

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // UITabBarItem 'tag' value is used to identify the saved tab bar item
    // Save current tab bar item to the defaults system.
    NSLog(@"dfdfd%d ",item.tag);
    switch (item.tag) {
        case 0:
        {
            _content = 1;
            [[DANotificationModule alloc] getNotificationListByType:@"reply" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
                _notifications = notificationList.items;
                [self.tableView reloadData];
            }];
        }
            break;
        case 1:
        {
            _content = 2;
            [[DANotificationModule alloc] getNotificationListByType:@"at" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
                _notifications = notificationList.items;
                [self.tableView reloadData];
            }];
        }
            break;
        case 2:
        {
            _content = 3;
            [[DAShortmailModule alloc] getUsers:0 count:20 callback:^(NSError *error, DAContactList *contact){
                theUsers = contact.items;
                user_count = contact.items.count;
                [self.tableView reloadData];
            }];
        }
            NSLog(@"私信");
            break;
        case 3:
        {
            _content = 4;
            [[DANotificationModule alloc] getNotificationListByType:@"invite,remove,follow" start:0 count:20 callback:^(NSError *error, DANotificationList *notificationList){
                _notifications = notificationList.items;
                [self.tableView reloadData];
            }];
        }
            break;
        default:
            NSLog(@"更多");
            break;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
