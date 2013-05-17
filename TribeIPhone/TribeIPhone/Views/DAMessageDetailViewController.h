//
//  DAMessageDetailViewController.h
//  TribeIPhone
//
//  Created by kita on 13-4-16.
//  Copyright (c) 2013年 kita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAMemberCell.h"
#import "DAMessageDetailCell.h"
#import "DACommentCell.h"
#import "DAContributeViewController.h"

@interface DAMessageDetailViewController : UIViewController<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) DAMessage* message;
@property (retain, nonatomic) DAMessageList* commentList;

- (IBAction)onCancelTouched:(id)sender;
- (IBAction)btnHomeTouched:(id)sender;

@end
