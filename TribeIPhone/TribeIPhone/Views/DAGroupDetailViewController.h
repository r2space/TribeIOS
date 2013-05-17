//
//  DAGroupDetailViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAGroupDetailCell.h"
#import "DAMessageCell.h"

@interface DAGroupDetailViewController : UIViewController <DAGroupFetcherDelegate, DAGroupJoinModuleDelegate, UITabBarDelegate>
- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblMessage;
@property (weak, nonatomic) NSString *gid;
@property (weak, nonatomic) IBOutlet UITabBarItem *barJoinOrLeave;
- (IBAction)btnHomeTouched:(id)sender;

@end
