//
//  DAFirstViewController.h
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAMessageModule.h>
#import "DAMessageCell.h"
#import "DAMessageDetailViewController.h"
#import "DAContributeViewController.h"

@interface DATimeLineViewController : UIViewController

- (IBAction)onRefreshClicked:(id)sender;
- (IBAction)onContributeClicked:(id)sender;

- (void)showMessages;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end