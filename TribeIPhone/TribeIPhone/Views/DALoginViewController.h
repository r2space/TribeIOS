//
//  DALoginViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DALoginModule.h>

@interface DALoginViewController : UIViewController
- (IBAction)onLoginTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtUserId;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end