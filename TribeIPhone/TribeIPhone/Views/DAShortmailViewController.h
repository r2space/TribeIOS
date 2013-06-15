//
//  DAShortmailViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

#import "DABaseViewController.h"

@interface DAShortmailViewController : DABaseViewController

- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onAddTouched:(id)sender;

@end
