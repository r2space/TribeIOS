//
//  DAShortmailStoryViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"

@interface DAShortmailStoryViewController : UIViewController<SocketIODelegate>
- (IBAction)onCancelTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barUser;
@property (weak, nonatomic) IBOutlet UITableView *tblStory;
@property (weak, nonatomic) IBOutlet UITextField *txtContent;
- (IBAction)onSendTouched:(id)sender;

@property (strong, nonatomic) NSString *uid;
- (IBAction)onTextExit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;

@end
