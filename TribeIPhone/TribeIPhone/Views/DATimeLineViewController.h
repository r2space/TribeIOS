//
//  DAFirstViewController.h
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAMessageCell.h"
#import "DAMessageDetailViewController.h"
#import "DAContributeViewController.h"
#import "DANotificationViewController.h"

#import "DABaseViewController.h"

@interface DATimeLineViewController : DABaseViewController

- (IBAction)onRefreshClicked:(id)sender;
- (IBAction)onContributeClicked:(id)sender;
- (IBAction)onNotifiactionClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
