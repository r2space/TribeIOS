//
//  DASettingViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/23.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DASettingViewController : UITableViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtServerAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtServerPort;
@property (weak, nonatomic) IBOutlet UIProgressView *prvSpace;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;

- (IBAction)didEndOnExit:(id)sender;

@end
