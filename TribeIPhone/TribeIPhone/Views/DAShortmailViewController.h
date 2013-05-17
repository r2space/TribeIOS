//
//  DAShortmailViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAShortmailViewController : UIViewController
- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblUsers;
- (IBAction)onAddTouched:(id)sender;

@end
