//
//  DAMemberMoreContainerViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAMemberMoreContainerViewController : UIViewController

- (IBAction)onCancelTouched:(id)sender;
- (IBAction)onSaveTouched:(id)sender;

@property (retain, nonatomic) DAUser *user;
@property (retain, nonatomic) NSString *userid;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (retain ,nonatomic) NSString *status;

@end
