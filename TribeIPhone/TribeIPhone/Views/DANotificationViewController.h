//
//  DANotificationViewController.h
//  TribeIPhone
//
//  Created by Antony on 13-5-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DANotificationCell.h"
#import "DAMessageCell.h"
#import <TribeSDK/DAShortmailModule.h>
#import <TribeSDK/DAUser.h>
#import <TribeSDK/DAUserList.h>
#import <TribeSDK/DANotificationModule.h>

@interface DANotificationViewController : UIViewController


- (IBAction)onCancelClicked:(id)sender;
- (IBAction)onCommentClicked:(id)sender;
- (IBAction)onAtClicked:(id)sender;
- (IBAction)onMailClicked:(id)sender;
- (IBAction)onAlertClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end
