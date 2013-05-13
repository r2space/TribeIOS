//
//  DAShortmailStoryViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAShortmailModule.h>
#import <TribeSDK/DAShortmailList.h>
#import <TribeSDK/DAShortmail.h>

@interface DAShortmailStoryViewController : UIViewController
- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barUser;
@property (weak, nonatomic) IBOutlet UITableView *tblStory;
@property (weak, nonatomic) IBOutlet UITextField *txtContent;
- (IBAction)onSendTouched:(id)sender;

@property (weak, nonatomic) NSString *uid;
- (IBAction)onTextExit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end
