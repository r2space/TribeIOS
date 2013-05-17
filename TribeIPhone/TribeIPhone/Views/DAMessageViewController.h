//
//  DASecondViewController.h
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DANotificationCell.h"
#import "DAMessageCell.h"

@interface DAMessageViewController : UIViewController

- (IBAction)onCommentClicked:(id)sender;
- (IBAction)onAtClicked:(id)sender;
- (IBAction)onMailClicked:(id)sender;
- (IBAction)onAlertClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end
