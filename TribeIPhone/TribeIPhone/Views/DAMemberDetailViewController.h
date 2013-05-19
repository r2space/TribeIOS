//
//  DAMemberDetailViewController.h
//  TribeIPhone
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAMemberDetailCell.h"
#import "DAMessageCell.h"
#import "DAMemberController.h"
#import "DAMemberMoreContainerViewController.h"

@interface DAMemberDetailViewController : UIViewController<UITabBarDelegate>

- (IBAction)onCancelTouched:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tblMessage;

- (IBAction)btnHomeTouched:(id)sender;


@property (weak, nonatomic) NSString *uid;
@property (weak, nonatomic) IBOutlet UITabBarItem *barFollow;

@end
